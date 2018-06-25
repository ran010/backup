class JobPostsController < ApplicationController
  before_action :job_posts_profile, only: [:show, :edit, :update, :destroy]
  before_action :is_owner?, only: [:edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @job_post = JobPost.new
  end

  def create
    @job_post =  current_recuitor.job_posts.create(job_posts_params)

    if @job_post.valid?
      redirect_to root_path
    else
        render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
     @job_post = JobPost.find(params[:id])
     @job_post.update(job_posts_params)
     if @job_post.valid?
        redirect_to root_path
     else
        render :edit, status: :unprocessable_entity
     end
    end
    def destroy
        @job_post = JobPost.find(params[:id])
        @job_post.destroy
        redirect_to root_path
    end

  private
  def job_posts_params
    params.require(:job_post).permit(:job_title,:no_of_vacancies,:experience,:description,:deadline,:recuitor_id,:job_type)
  end

  def job_posts_profile
    @job_post = JobPost.find(params[:id])
  end

  def is_owner?
   redirect_to root_path if JobPost.find(params[:id]).recuitor != current_recuitor
  end
end