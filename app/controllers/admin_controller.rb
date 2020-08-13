class AdminController < ApplicationController
    before_action :check_if_admin, only: [:index]

    def index
    end

    def check_if_admin
        if current_user == nil || current_user.is_admin == false
            flash[:danger] = "Vous ne pouvez pas consulter le profil d'un autre utilisateur"
            redirect_to events_path
        end
    end
end
