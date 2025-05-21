class EmployeeTacoMastersController < ApplicationController
  def new
    @xx_user_id = XxUserId.new
  end

  def index
  end
  
  def search
    @employee_search = XxUserId.where("UserID LIKE ?", "%#{params[:search]}%")
  end
  
  def create
    @employee_save = XxUserId.new(employee_create_params)
    @employee_save.InsUserID = "0000"
    @employee_save.InsPGID = "C01M001"
    @employee_save.UpdCount = 1
    if @employee_save.save!
       redirect_to employee_index_path
    else
       render :new
    end
  end

  def update
    @employee_update = XxUserId.find(params[:UserID])
    @employee_update.UserName = params[:xx_user_id][:UserName]
    @employee_update.password = params[:xx_user_id][:password]
    @employee_update.UserKubun = params[:xx_user_id][:UserKubun]
    @employee_update.MailAdress = params[:xx_user_id][:MailAdress]
    if @employee_update.save!
       redirect_to employee_index_path
    else
       render :edit
    end
  end

  def destroy
  end

  private
  def employee_create_params
    params.require(:xx_user_id).permit(:UserName, :password, :UserKubun, :MailAdress)
  end
end