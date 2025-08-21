class UsersController < ApplicationController
  def index
    users = User
              .by_company(params[:company_identifier])
              .by_username(search_params[:username])
    render json: users.all
  end

  def autocomplete
    users = User.where("username ILIKE ? OR display_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
                .limit(10)
    render json: users.select(:id, :username, :display_name)
  end

  private

  def search_params
    params.permit(:username)
  end
end
