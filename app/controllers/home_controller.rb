class HomeController < ApplicationController
  def index

    @disponibilites_avenir = get_disponibilites_avenir_non_attribue
    @disponibilites = Disponibilite.all
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
