class BandsController < ApplicationController
  # GET /bands
  # GET /bands.json
  def index
    @bands = Band.all
    if (params["tokenformat"] and params["q"])
      tokenbands = Array.new
      @bands.each do |b|
        if (b.name.downcase.starts_with? params["q"].downcase )
          tokenbands.push({"value" => b.id, "name" => b.name})
        end
      end
      @bands = tokenbands
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json:  @bands }
    end
  end

  # GET /bands/1
  # GET /bands/1.json
  def show
    @band = Band.find(params[:id])
    if((@band.last_fm_id == nil or @band.last_fm_id == "") and !@band.is_classical and !@band.is_jazz and !@band.is_local)
      @band.last_fm_id = CGI.escape(@band.name)
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @band }
    end
  end

  # GET /bands/new
  # GET /bands/new.json
  def new
    @band = Band.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @band }
    end
  end

  # GET /bands/1/edit
  def edit
    @band = Band.find(params[:id])
  end

  # POST /bands
  # POST /bands.json
  def create
    @band = Band.new(params[:band])
    @band.save
    render json: @band, status: :created, location: @band
  end

  # PUT /bands/1
  # PUT /bands/1.json
  def update
    @band = Band.find(params[:id])

    respond_to do |format|
      if @band.update_attributes(params[:band])
        format.html { redirect_to @band, notice: 'Band was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bands/1
  # DELETE /bands/1.json
  def destroy
    @band = Band.find(params[:id])
    @band.destroy

    respond_to do |format|
      format.html { redirect_to bands_url }
      format.json { head :ok }
    end
  end
end

