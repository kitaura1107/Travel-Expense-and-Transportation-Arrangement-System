class EmployeeTacoMastersController < ApplicationController
  def new
    @xx_user_id = XxUserId.new
  end

  def index
    @xx_user_ids = XxUserId.all
  end
  
  def search
    keyword = params[:query].to_s.strip
    @xx_user_id = XxUserId.find_by(UserID: keyword)
    @record_found = @xx_user_id.present?
    @xx_user_id ||= XxUserId.new(UserID: keyword)
    @form_flag = keyword.present?
    render :new
  end

  
  def create
    @employee_save = XxUserId.new(employee_create_params)
    @employee_save.InsUserID = current_xx_user_id&.UserID || "0000"
    @employee_save.InsPGID = "C01M001"
    @employee_save.UpdCount = 1
    if @employee_save.save
       redirect_to employee_taco_masters_path
    else
       render :new
    end
  end

  def update
    @employee_update = XxUserId.find_by(UserID: params[:xx_user_id][:UserID])
    if @employee_update
      @employee_update.assign_attributes(employee_create_params)
      @employee_update.UpdCount += 1
      @employee_update.UpdUserID = current_xx_user_id&.UserID || "0000"
      @employee_update.UpdPGID = "C01M001"
      if @employee_update.save
        redirect_to employee_taco_masters_path notice: "更新しました"
      else
        flash.now[:alert] = "更新できませんでした"
        render :new
      end
    end
  end

  def destroy
    employee_delete = XxUserId.find_by(UserID: params[:id])
    if employee_delete
      employee_delete.destroy
      redirect_to employee_taco_masters_path notice: "削除しました"
    else
      redirect_to employee_taco_masters_path alert: "削除できませんでした"
    end
  end

  private
  def employee_create_params
    params.require(:xx_user_id).permit(:UserID, :UserName, :password, :UserKubun, :MailAdress)
  end
end