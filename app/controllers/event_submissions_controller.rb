class EventSubmissionsController < ApplicationController

    def index
        @events_to_validate = Event.all.find_by(validated: false)
    end

    def edit
        @event = Event.find(params[:id])
      end
    
    def update
        Event.find(params[:id]).update(validated: true)
        redirect_to :controller => 'admin', :action => 'index'
    end
      

end
