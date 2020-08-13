class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :edit, :create, :update]
  before_action :check_if_validated, only: [:show, :edit, :update] 



  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @count = @event.attendances.count
    @user = User.find(current_user.id)
    @end_date = (@event.start_date + (@event.duration * 86400)).to_date
    @attendances = Attendance.exists?(event_id: @event.id, user_id: @user.id)
    @administrator = Event.exists?(id: params[:id], user_id: @user.id)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(title: params[:title], description: params[:description], price: params[:price], start_date: params[:start_date], duration: params[:duration], location: params[:location], user: User.find(current_user.id)) 

    if @event.save
      flash[:success] = "Merci #{@event.user.email} ! Nous avons pu créer l'event : #{@event.title} "
      redirect_to :controller => 'events', :action => 'index'
    else
      flash[:danger] = "Nous n'avons pas réussi à créer l'event pour la (ou les) raison(s) suivante(s) : #{@event.errors.full_messages.each {|message| message}.join('')}"
      render :action => 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def check_if_validated
    @event = Event.find(params[:id])
    if @event.validated == nil || @event.validated == false
        flash[:danger] = "Vous ne pouvez pas consulter un événement non validé"
        redirect_to events_path
    end
  end
end
