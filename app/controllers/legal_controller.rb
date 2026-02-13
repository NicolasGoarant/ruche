class LegalController < ApplicationController
  # CSRF token envoyé via X-CSRF-Token dans le JS (assistant.html.erb)

  # Rate limiting par session : max 20 requêtes par heure
  RATE_LIMIT = 20
  RATE_WINDOW = 1.hour

  def assistant
  end

  def chat
    # --- Rate limiting ---
    if rate_limited?
      return render json: {
        error: "Vous avez atteint la limite de #{RATE_LIMIT} messages par heure. Réessayez dans quelques minutes."
      }, status: :too_many_requests
    end
    increment_rate_counter!

    user_message = params[:message]
    conversation_history = params[:history] || []

    if user_message.blank?
      return render json: { error: "Le message ne peut pas être vide." }, status: :unprocessable_entity
    end

    api_key = ENV['ANTHROPIC_API_KEY']

    system_prompt = <<~PROMPT
      Tu es un conseiller juridique bienveillant spécialisé dans l'accompagnement des réfugiés et personnes déplacées en France.

      TON STYLE D'ÉCRITURE :
      - Écris de manière fluide et naturelle, comme si tu parlais à quelqu'un en face à face
      - Utilise un ton chaleureux et rassurant
      - Évite le jargon administratif autant que possible
      - Quand tu dois utiliser un terme technique, explique-le simplement
      - N'utilise JAMAIS de mots entièrement en majuscules
      - Utilise des emojis pour structurer (✅ 📋 ⏱ 📍) mais avec parcimonie

      STRUCTURE DE TES RÉPONSES :

      1. Commence par reformuler et valider ta compréhension de la situation
         "Si je comprends bien, vous êtes arrivé d'Ukraine en mars 2022 et vous vous inquiétez pour..."

      2. Explique la situation juridique actuelle de la personne dans un langage simple
         "Votre protection temporaire vous donne actuellement le droit de..."

      3. Présente les options qui s'offrent à elle, sous forme de chemins possibles
         "Vous avez plusieurs voies possibles devant vous..."
         - Option 1 : [description naturelle avec avantages et délais]
         - Option 2 : [description naturelle avec avantages et délais]

      4. Donne tes recommandations personnalisées
         "Dans votre situation, je vous conseille de..."

      5. Termine avec les ressources locales à Nancy
         "Pour vous accompagner dans ces démarches, vous pouvez vous tourner vers..."

      6. Ajoute le disclaimer à la fin
         "Ces informations sont basées sur la réglementation actuelle. Pour une analyse personnalisée de votre dossier, n'hésitez pas à consulter France Terre d'Asile Nancy (03 83 35 05 35)."

      RÈGLES IMPORTANTES :
      - Ne commence jamais par citer des articles de loi
      - Si tu dois mentionner un texte légal, fais-le en fin de section entre parenthèses
      - Pose des questions de clarification si tu as besoin de plus d'informations
      - Sois empathique : ces personnes vivent souvent dans l'incertitude et l'anxiété
      - Donne des informations concrètes et actionnables

      CONNAISSANCES À MOBILISER :

      Protection temporaire ukrainienne :
      - Actuellement valide jusqu'au 4 mars 2026
      - Peut être prolongée même si le conflit cesse (si le retour n'est pas sûr)
      - Donne droit au travail, aux soins, au logement
      - Compatible avec une demande d'asile ou un autre titre de séjour

      Demande d'asile classique :
      - Procédure normale : environ 6 à 12 mois
      - Vous restez en France pendant l'instruction
      - Droit au travail après 6 mois de demande
      - En cas de refus, possibilité de recours devant la CNDA

      Naturalisation :
      - Nécessite généralement 5 ans de résidence régulière en France
      - Exige un niveau de français B1 à l'oral
      - Demande des ressources stables et une intégration réussie

      Titres de séjour pour motifs privés :
      - Vie privée et familiale (si liens familiaux forts en France)
      - Salarié (si CDI ou promesse d'embauche)
      - Chacun a ses propres critères et délais

      RESSOURCES À NANCY :
      - Préfecture de Meurthe-et-Moselle : 1 rue Préfet Claude Erignac
      - France Terre d'Asile : 03 83 35 05 05 (permanences juridiques gratuites)
      - La Cimade : permanences les mardis de 14h à 17h
      - OFII Grand Est : pour les rendez-vous obligatoires

      Écris de manière humaine, accessible et rassurante. Les personnes qui te consultent sont souvent perdues dans un système complexe.
    PROMPT

    messages = conversation_history + [
      { role: 'user', content: user_message }
    ]

    begin
      uri = URI('https://api.anthropic.com/v1/messages')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.read_timeout = 30

      request = Net::HTTP::Post.new(uri.path)
      request['Content-Type'] = 'application/json'
      request['x-api-key'] = api_key
      request['anthropic-version'] = '2023-06-01'

      request.body = {
        model: 'claude-sonnet-4-20250514',
        max_tokens: 2000,
        system: system_prompt,
        messages: messages
      }.to_json

      response = http.request(request)
      data = JSON.parse(response.body)

      if data['content'] && data['content'][0]
        assistant_message = data['content'][0]['text']

        render json: {
          response: assistant_message,
          history: messages + [{ role: 'assistant', content: assistant_message }]
        }
      else
        Rails.logger.error("Anthropic API error: #{data['error']}")
        render json: { error: "Une erreur est survenue. Réessayez dans un instant." }, status: 500
      end
    rescue Net::ReadTimeout
      render json: { error: "Le serveur met trop de temps à répondre. Réessayez." }, status: 504
    rescue => e
      Rails.logger.error("Legal chat error: #{e.message}")
      render json: { error: "Une erreur est survenue. Réessayez dans un instant." }, status: 500
    end
  end

  private

  def rate_limited?
    timestamps = session[:legal_chat_timestamps] || []
    cutoff = Time.current - RATE_WINDOW
    recent = timestamps.select { |t| Time.parse(t) > cutoff }
    recent.size >= RATE_LIMIT
  end

  def increment_rate_counter!
    timestamps = session[:legal_chat_timestamps] || []
    cutoff = Time.current - RATE_WINDOW
    # Nettoyer les anciens + ajouter le nouveau
    session[:legal_chat_timestamps] = timestamps
      .select { |t| Time.parse(t) > cutoff }
      .push(Time.current.iso8601)
  end
end
