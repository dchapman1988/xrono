class Api::V1::ProjectsController < Api::V1::BaseController
  def index
    @bucket = Project
    @bucket = @bucket.sort_by_name.for_client_id(params[:client_id])
    unless admin?
      @bucket = @bucket.for_user_and_role(current_user, :developer)
    end
    @projects = @bucket.order("name").all
    render :json => @projects
  end
end
