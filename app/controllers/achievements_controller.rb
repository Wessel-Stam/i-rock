class AchievementsController < ActionController::Base

    before_action :authenticate_user!, only:[:new, :create , :edit , :update , :destroy]
    before_action :owners_only, only: [:edit,:update,:destroy]

    def index
        @achievements = Achievement.public_access
    end

    def edit 

    end


    def update 

        if @achievement.update(achievement_params)
            redirect_to achievement_path(@achievement) 
        else
            render :edit
        end
    end

    def destroy
        @achievement.destroy
        redirect_to achievement_path
    end

    def new 
        @achievement = Achievement.new
    end

    def create 
        @achievement = Achievement.new(achievement_params)
        if @achievement.save 
            redirect_to achievement_url(@achievement), notice: 'Achievement has been created'
        else 
            render :new
        end
    end

    def show
        @achievement = Achievement.find(params[:id])
        @description = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@achievement.description)
    end



    private

    def achievement_params
        params.require(:achievement).permit(:title, :description, :privacy, :cover_image, :featured)
    end

    def owners_only
        @achievement = Achievement.find(params[:id])
        if current_user != @achievement.user
            redirect_to achievements_path
        end
    end
end
