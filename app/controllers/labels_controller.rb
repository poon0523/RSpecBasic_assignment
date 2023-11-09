class LabelsController < ApplicationController
    before_action :set_label, only: %i[ edit update destroy ]

    def index
        @labels = Label.where(user: current_user)
    end

    def new
        @label = Label.new
    end

    def create
        @label = current_user.labels.new(label_params)
        if @label.save
            redirect_to labels_path, success:t('notice.successful_label',action: "登録")
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @label.update(label_params)
            redirect_to labels_path, success:t('notice.successful_label',action: "更新")
        else
            render :edit
        end
    end

    def destroy
        if @label.destroy
            redirect_to labels_path, success:t('notice.successful_label',action: "削除")
        else
            render :index
        end
    end

    private

    def set_label
        @label = Label.find(params[:id])
    end
  

    def label_params
        params.require(:label).permit(:name)
    end
  
end
