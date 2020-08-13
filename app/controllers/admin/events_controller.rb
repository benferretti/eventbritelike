class Admin::EventsController < ApplicationController
    before_action :check_if_admin

    def index
        @events = Event.all
        @events_to_validate = Event.all.find_by(validated: false)
    end


    def check_if_admin
        if current_user == nil || current_user.is_admin == false
            flash[:danger] = "Vous ne pouvez pas consulter le profil d'un autre utilisateur"
            redirect_to events_path
        end
    end
end
