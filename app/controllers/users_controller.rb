class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]
  before_action :authority_check, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "updated user data"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following_users.page(params[:page])
    render 'result_follow'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users.page(params[:page])
    render 'result_follow'
  end

  def favorite
    @user = User.find(params[:id])
    @micropost = @user.microposts.build
    @microposts = @user.favorite_microposts.page(params[:page])
    render 'result_favorite'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :description, :location)
  end

  def set_user
    @user = User.find(params[:id])
  end

  # 対象レコードの編集権限をチェック
  def authority_check
    # ログイン中のユーザーIDと、対象データのユーザーIDが一致しない場合はリダイレクト
    unless session[:user_id] == @user.id
      redirect_to @user
    end
  end

end
