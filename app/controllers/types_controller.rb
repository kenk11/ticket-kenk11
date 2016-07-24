class TypesController < ApplicationController
  def index
    @types = TicketType.all
  end

  def new
    @type = TicketType.new
    @events = Event.all
  end

  def create
    @type = TicketType.new type_params
    if @type.save
      flash[:success] = 'Create new ticket type successful!'
      redirect_to list_path
    else
      flash[:error] = "Error: #{@type.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def edit
    @type = TicketType.find(params[:id])
    @events = Event.all
  end

  def update
    @type = TicketType.find(params[:id])
    if @type.update(type_params)
      flash[:success] = 'Updated ticket type successfully!'
      redirect_to 'index'
    else
      flash[:error] = "Error: #{@type.errors.full_messages.to_sentence}"
      render 'edit'
    end
  end


  private
  def type_params
    params.require(:ticket_type).permit(:name, :price, :max_quantity)
  end
end
