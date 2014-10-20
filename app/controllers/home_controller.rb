class HomeController < ApplicationController
  def index

    @disponibilites_avenir = Disponibilite.where("utilisateur_remplacant_id is null and date_heure_debut between :date_debut and :date_fin", {date_debut: Date.current, date_fin: Date.current + 2.months})

=begin
    if session[:token].nil?

      redirect_to "/auth/google_oauth2"

    else

      client = Google::APIClient.new
      client.authorization.access_token = session[:token]
      service = client.discovered_api('calendar', 'v3')

      result = client.execute(:api_method => service.events.list,
                               :parameters => {'calendarId' => 'nickdemers@gmail.com',
                                               'timeMin' => DateTime.now,
                                               'timeMax' => DateTime.now + 600.days})

      if !result.nil?

        @events_calendar = result.data.items

      end
    end
=end
  end
end
