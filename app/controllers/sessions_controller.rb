class SessionsController < ApplicationController

  def create

    #What data comes back from OmniAuth?
    @auth = request.env["omniauth.auth"];
    #Use the token from the data to request a list of calendars
    @token = @auth["credentials"]["token"];
    session[:token] = @token;

    redirect_to root_url, :notice => 'Signed In!'

  end
end
