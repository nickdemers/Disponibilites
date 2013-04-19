class RemplacementsController < ApplicationController
  # GET /remplacements
  # GET /remplacements.json
  def index
    @remplacements = Remplacement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @remplacements }
    end
  end

  # GET /remplacements/1
  # GET /remplacements/1.json
  def show
    @remplacement = Remplacement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @remplacement }
    end
  end

  # GET /remplacements/new
  # GET /remplacements/new.json
  def new
    @remplacement = Remplacement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @remplacement }
    end
  end

  # GET /remplacements/1/edit
  def edit
    @remplacement = Remplacement.find(params[:id])
  end

  # POST /remplacements
  # POST /remplacements.json
  def create

    #@auth = request.env["omniauth.auth"]
    #Use the token from the data to request a list of calendars
    #@token = @auth["credentials"]["token"]
    client = Google::APIClient.new
    client.authorization.access_token = session[:token]
    service = client.discovered_api('calendar', 'v3')
    #@result = client.execute(
    #    :api_method => service.calendar_list.list,
    #    :parameters => {},
    #    :headers => {'Content-Type' => 'application/json'})


    event = {
        'summary' => 'Remplacement test 1',
        'location' => 'Somewhere',
        'start' => {
            'dateTime' => '2013-03-25T11:00:00.000-07:00'
        },
        'end' => {
            'dateTime' => '2013-03-25T11:25:00.000-07:00'
        },
        'attendees' => [
            {
                'email' => 'nickdemers@gmail.com'
            }
        ]
    };

    result = client.execute(:api_method => service.events.insert,
                            :parameters => {'calendarId' => 'nickdemers@gmail.com'},
                            :body => JSON.dump(event),
                            :headers => {'Content-Type' => 'application/json'});

  @remplacement = Remplacement.new(params[:remplacement]);

    respond_to do |format|
      if @remplacement.save
        format.html { redirect_to @remplacement, notice: 'remplacements was successfully created.' }
        format.json { render json: @remplacement, status: :created, location: @remplacement }
      else
        format.html { render action: "new" }
        format.json { render json: @remplacement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /remplacements/1
  # PUT /remplacements/1.json
  def update
    @remplacement = Remplacement.find(params[:id])

    respond_to do |format|
      if @remplacement.update_attributes(params[:remplacement])
        format.html { redirect_to @remplacement, notice: 'remplacements was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @remplacement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /remplacements/1
  # DELETE /remplacements/1.json
  def destroy
    @remplacement = Remplacement.find(params[:id])
    @remplacement.destroy

    respond_to do |format|
      format.html { redirect_to remplacements_index_url }
      format.json { head :no_content }
    end
  end
end
