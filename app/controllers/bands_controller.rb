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

end

