class DepartmentsController < ApplicationController
  def new
    @xxm_bumon = XxmBumon.new
  end

  def index
    @xxm_bumons = XxmBumon.all
  end
  
  def search
    keyword = params[:query].to_s.strip
    @xxm_bumon = XxmBumon.find_by(BumonCD: keyword)
    @record_found = @xxm_bumon.present?
    @xxm_bumon ||= XxmBumon.new
    @form_flag = keyword.present?
    render :new
  end

  def create
    @department_save = XxmBumon.new(department_create_params)
    @department_save.InsUserID = current_xx_user_id&.UserID || "0000"
    @department_save.InsPGID = "C01M002"
    @department_save.UpdCount = 1
    if @department_save.save
       redirect_to departments_path
    else
       render :new
    end
  end
  
  def update
    @department_update = XxmBumon.find_by(BumonCD: params[:xxm_bumon][:BumonCD])
    if @department_update
        @department_update.assign_attributes(department_create_params)
        @department_update.UpdCount += 1
        @department_update.UpdUserID = current_xx_user_id&.UserID || "0000"
        @department_update.UpdPGID = "C01M002"
      if @department_update.save
        redirect_to departments_path notice: "更新しました"
      else
        flash.now[:alert] = "更新できませんでした"
        render :new  
      end
    end
  end

  def destroy
    department_delete = XxmBumon.find_by(BumonCD: params[:id])
    if department_delete
      department_delete.destroy
      redirect_to departments_path notice: "削除しました"
    else
      redirect_to departments_path alert: "削除できませんでした"
    end
  end

  private
 
  def department_create_params
    params.require(:xxm_bumon).permit(:BumonCD, :BumonName)
  end
end
