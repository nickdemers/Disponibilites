require 'omniauth/google_oauth2'
require 'google/api_client'

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, "1029037884002-0sjm4ggg4v16sv2rosen9fhte8ifrpf6.apps.googleusercontent.com","bACH1WEk0aVdu4VrW5_frhKm", {
             :access_type => 'offline',
             :scope => 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
             :approval_prompt => ''}
end