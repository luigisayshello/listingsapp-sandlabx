class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  #chptr_8.2 Devise keyword :authenticate_user! which checks to make sure a user is signed in
  # just " before_action :authenticate_user!" = requires login just to see the page.
  # The rest says that you only need to sign whe you try to do the things inside the [].
  before_action :authenticate_user!, only: [:seller, :new, :create, :edit, :update, :destroy] 
  # This line impedes that a user edit update or destroy others listings VERY USEFUL.
  # only: [:edit, :update, :destroy] specify when Rails needs to check when a user is signed in
  before_action :check_user, only: [:edit, :update, :destroy]

  # GET /listings
  # GET /listings.json

  def seller
    @listings = Listing.where(user: current_user).order("created_at DESC")
  end

  def index
    @listings = Listing.all.order("created_at DESC")
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    
    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @listing }
      else
        format.html { render action: 'new' }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image)
    end
    # This function checks to see if the current user who is logged in is the same person who created the listing in question
    # != not equal
    def check_user
      if current_user != @listing.user
        redirect_to root_url, alert: "Sorry, this listing belongs to someone else"
      end
   end
end
