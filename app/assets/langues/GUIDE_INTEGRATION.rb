# ==========================================
# GUIDE D'INTÉGRATION i18n — la Ruche
# ==========================================

# =====================
# 1. FICHIERS DE LOCALE
# =====================
# Copie les 6 fichiers .yml dans config/locales/ :
#   config/locales/fr.yml
#   config/locales/en.yml
#   config/locales/ar.yml
#   config/locales/uk.yml
#   config/locales/prs.yml   (Dari)
#   config/locales/es.yml


# ====================================
# 2. CONFIG — config/application.rb
# ====================================
# Ajoute dans la class Application :

    config.i18n.available_locales = [:fr, :en, :ar, :uk, :prs, :es]
    config.i18n.default_locale = :fr
    config.i18n.fallbacks = true


# ====================================
# 3. APPLICATION CONTROLLER
# ====================================
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || cookies[:locale] || I18n.default_locale
    cookies[:locale] = { value: I18n.locale, expires: 1.year.from_now }
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end
end


# ====================================
# 4. ROUTES — config/routes.rb
# ====================================

Rails.application.routes.draw do
  scope "(:locale)", locale: /fr|en|ar|uk|prs|es/ do
    root "pages#home"
    get "philosophie", to: "pages#philosophie"
    get "assistant-juridique", to: "legal#assistant"
    post "assistant-juridique/chat", to: "legal#chat"
    resources :contributions, only: [:new, :create, :show]
    # ... tes autres routes
  end
end


# ====================================
# 5. SUPPORT RTL (arabe et dari)
# ====================================
# Dans application_html.erb, ajoute dir="rtl" dynamiquement :

# <html lang="<%= I18n.locale %>" dir="<%= %i[ar prs].include?(I18n.locale) ? 'rtl' : 'ltr' %>">

# Et ajoute ce CSS dans ton application.css ou dans le layout :

# [dir="rtl"] {
#   text-align: right;
# }
# [dir="rtl"] .navbar {
#   flex-direction: row-reverse;
# }
# [dir="rtl"] .nav-links {
#   flex-direction: row-reverse;
# }
# [dir="rtl"] .logo {
#   flex-direction: row-reverse;
# }
# [dir="rtl"] .card-meta {
#   direction: rtl;
# }
# [dir="rtl"] .portrait-header {
#   flex-direction: row-reverse;
# }
# [dir="rtl"] .hero-cta {
#   flex-direction: row-reverse;
# }
# [dir="rtl"] .back-link {
#   direction: rtl;
# }


# ====================================
# 6. UTILISATION DANS LES VUES
# ====================================
# Remplace le texte en dur par des appels t() :
#
# AVANT :
#   <h1>La plateforme d'aide aux réfugiés <em>en France.</em></h1>
#
# APRÈS :
#   <h1><%= t('hero.title_html').html_safe %></h1>
#
# Pour les clés avec HTML (disclaimer, welcome, title_html),
# utilise .html_safe ou raw() :
#   <%= raw t('assistant.disclaimer_html') %>
#
# Pour les placeholder dans les formulaires :
#   placeholder: t('contribution_form.placeholder_title')


# ====================================
# 7. EXEMPLES DE REMPLACEMENT PAR VUE
# ====================================

# --- home.html.erb ---
# <h1><%= t('hero.title_html').html_safe %></h1>
# <p><%= t('hero.subtitle') %></p>
# <a href="#carte" class="cta-primary"><%= t('hero.cta_map') %></a>
# <a href="<%= new_contribution_path %>" class="cta-secondary"><%= t('hero.cta_contribute') %></a>
# <h2><%= t('map.title') %></h2>
# <p><%= t('map.subtitle') %></p>
# <span><%= t('map.filter_rights') %></span>
# <span><%= t('map.filter_fle') %></span>
# <span><%= t('map.filter_entrepreneurship') %></span>
# <span><%= t('map.filter_community') %></span>
# <h2><%= t('contributions_section.title') %></h2>
# <p><%= t('contributions_section.subtitle') %></p>
# <h2><%= t('portraits.title') %></h2>
# <p><%= t('portraits.subtitle') %></p>
# <strong><%= t('footer.brand') %></strong>
# <p><%= t('footer.tagline') %></p>

# --- assistant.html.erb ---
# <h1><%= t('assistant.title') %></h1>
# <p><%= t('assistant.subtitle') %></p>
# <div class="disclaimer"><%= raw t('assistant.disclaimer_html') %></div>
# <textarea placeholder="<%= t('assistant.placeholder') %>">
# <button><%= t('assistant.send') %></button>

# --- new.html.erb ---
# <h1><%= t('contribution_form.title') %></h1>
# <p class="intro"><%= t('contribution_form.intro') %></p>
# etc.

# --- philosophie.html.erb ---
# <h1><%= t('philosophie.hero_title') %></h1>
# etc.
