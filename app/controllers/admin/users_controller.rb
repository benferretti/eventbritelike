class Admin::UsersController < ApplicationController
    before_action :check_if_admin
    
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @events = Event.all
        @attendances = Attendance.all
    end


    def check_if_admin
        if current_user == nil || current_user.is_admin == false
            flash[:danger] = "Vous ne pouvez pas consulter le profil d'un autre utilisateur"
            redirect_to events_path
        end
    end
end
