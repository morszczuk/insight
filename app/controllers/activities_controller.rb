class ActivitiesController < ApplicationController
    def index
        @activities = Activity.all  
    end

    def new
        @activity = Activity.new
    end

    def create
        activity = Activity.new(activity_params)
        if activity.save
            redirect_to action: "index", notice: "Poprawnie dodano nowy trening!"
        else
            redirect_to action: "new"
        end
    end

    def show 
        @activity = Activity.find(params[:id])
    end

    private
    def activity_params
        params.require(:activity).permit(:name, :gpx)    
    end
end