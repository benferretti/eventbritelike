class AttendancesController < ApplicationController
    before_action :authenticate_admin, only: [:index]

    def index
        @attendances = Attendance.all
        @event = Event.find(params[:event_id])
    end

    def new
        @event = Event.find(params[:event_id])
    end
    
    def create
      @event = Event.find(params[:event_id])
      @attendance = Attendance.new(event: Event.find(params[:event_id]), user: User.find(current_user.id), stripe_customer_id: "Texte test")
      if @attendance.save
        flash[:success] = "Merci #{@attendance.user.first_name} ! Nous avons pu vous inscrire à l'event : #{@event.title} "
        redirect_to :controller => 'users', :action => 'show' , id: User.find(current_user.id)
      else
        flash[:danger] = "Nous n'avons pas réussi à vous inscrire pour la (ou les) raison(s) suivante(s) : #{@attendance.errors.full_messages.each {|message| message}.join('')}"
        render :action => 'new'
      end
    end

    def authenticate_admin
        unless current_user.id == Event.find(params[:event_id]).user_id
        flash[:danger] = "Vous ne pouvez pas consulter cette page"
        redirect_to events_path
        end
    end

end
