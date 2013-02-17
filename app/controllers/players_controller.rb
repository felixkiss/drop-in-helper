class PlayersController < ApplicationController
	# GET /players/search/:gamertag
	def search
		# @players = Player.where("gamertag LIKE ?", "#{params[:gamertag]}%") if params[:gamertag].present?
		@players = Player.where("gamertag_lower LIKE ?", "%#{params[:gamertag].downcase}%").order(:gamertag_lower) if params[:gamertag].present?

		respond_to do |format|
			format.html # search.html.erb
			format.json { render json: @players }
		end
	end

  # GET /players
  # GET /players.json
  def index
    @players = Player.order(:gamertag_lower).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/new
  # GET /players/new.json
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render json: @player, status: :created, location: @player }
      else
        format.html { render action: "new" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  # PUT /players/1/bad
  # PUT /players/gamertag/bad
  def bad
  	unless is_numeric? params[:id]
  		@player = Player.create({ gamertag: params[:id] })
  	else
  		@player = Player.find(params[:id])
  	end

  	@player.rating = "bad"
  	@player.save

  	respond_to do |format|
  		format.js
  	end
  end

  # PUT /players/1/good
  # PUT /players/gamertag/good
  def good
  	unless is_numeric? params[:id]
  		@player = Player.create({ gamertag: params[:id] })
  	else
  		@player = Player.find(params[:id])
  	end

  	@player.rating = "good"
  	@player.save

  	respond_to do |format|
  		format.js
  	end
  end

  def stats
  	@bad_players = Player.where(rating: "bad")
  	@good_players = Player.where(rating: "good")

  	respond_to do |format|
  		format.html
  	end
  end

private

  def is_numeric?(obj) 
	   obj.to_s.match(/\A[+-]?\d+?\Z/) == nil ? false : true
	end
end
