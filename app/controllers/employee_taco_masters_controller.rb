class EmployeeTacoMastersController < ApplicationController
  def new
    @xx_user_id = XxUserId.new
  end

  def index
  end
  

  def create
    @employee_save = XxUserId.new(employee_create_params)
    @employee_save.InsUserID = current_xx_user_id&.UserID || "0000"
    @employee_save.InsPGID = "C01M001"
    @employee_save.UpdCount = 1
    if @employee_save.save
       redirect_to employee_index_path
    else
       render :new
    end
  end

  def update
  end

  def destroy
  end

  private
  def employee_create_params
    params.require(:xx_user_id).permit(:UserName, :encrypted_password, :UserKubun, :email)
  end
end