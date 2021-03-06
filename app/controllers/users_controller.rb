class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update] 
  before_filter :correct_user, only: [:edit, :update] 
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = t"flash.profile_updated"
      sign_in @user
      redirect_to @user
    else
      render "edit"  
    end
  end
  
  def edit
    if(!current_user.nil?)
      @user = current_user 
      #User.find(params[:id])
    else
      redirect_to root_url
    end
  end
  
  def destroy
    if current_user.admin? && !current_user?(User.find(params[:id])) 
      User.find(params[:id]).destroy
      flash[:success] = t("flash.user_destroyed")
      redirect_to users_url
    else 
      redirect_to users_url
    end
  end
  
  private
    
    def signed_in_user
      store_location
      redirect_to signin_url, notice: I18n.t("flash.signin") unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
