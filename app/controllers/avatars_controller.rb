class AvatarsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @event = Event.find(params[:event_id])
    @event.avatar.attach(params[:avatar])
    redirect_to(event_path(@event))
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
