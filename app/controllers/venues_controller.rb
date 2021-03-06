class VenuesController < ApplicationController
  def index
    @venues = Venue.all
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new venue_params
    if @venue.save
      flash[:success] = 'Create new venue successful!'
      redirect_to venues_path
    else
      flash[:error] = "Error: #{@venue.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    @venue = Venue.find(params[:id])
    if @venue.update(venue_params)
      flash[:success] = 'Updated venue successfully!'
      redirect_to venues_path
    else
      flash[:error] = "Error: #{@venue.errors.full_messages.to_sentence}"
      render 'edit'
    end
  end

  def destroy
    @venue = Venue.find(params[:id])
    if @venue.destroy
      flash[:success] = 'Deleted venue successfully!'
      redirect_to venues_path
    else
      flash[:error] = "Error: #{@venue.errors.full_messages.to_sentence}"
    end
  end


  private
  def venue_params
    params.require(:venue).permit(:name, :full_address, :region_id)
  end
end
