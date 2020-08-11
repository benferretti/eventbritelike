class UsersController < ApplicationController
    before_action :authenticate_user, only: [:new, :show, :edit, :create, :update] 


    def show
        @user = User.find(params[:id])
        @events = Event.all
    end

    private

    def authenticate_user
        unless current_user == User.find(params[:id])
        flash[:danger] = "Vous ne pouvez pas consulter le profil d'un autre utilisateur"
        redirect_to events_path
        end
    end

end
