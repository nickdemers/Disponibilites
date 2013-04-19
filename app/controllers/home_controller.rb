class HomeController < ApplicationController
  def index

    if session[:token].nil?

      redirect_to "/auth/google_oauth2"

    else

      client = Google::APIClient.new
      client.authorization.access_token = session[:token]
      service = client.discovered_api('calendar', 'v3')

      result = client.execute(:api_method => service.events.list,
                               :parameters => {'calendarId' => 'nickdemers@gmail.com'})

      if !result.nil?

        @events_calendar = result.data.items

        @events_calendar.each do |e|
          puts e.summary
        end
      end
    end
  end
end
