class TravelRequestsController < ApplicationController
  def new
    @xx_ryohi_t = XxRyohiT.new
    @bumon_options = XxmBumon.pluck(:BumonName, :BumonCD)
    @user_type = current_xx_user_id&.UserKubun.to_i
  end

  def index
    @xx_ryohi_t = XxRyohiT.all
  end

  def search
    keyword = params[:query].to_s.strip
    @xx_ryohi_t = XxRyohiT.find_by(RefNO: keyword)
    @record_found = @xx_ryohi_t.present?
    @bumon_options = XxmBumon.pluck(:BumonName, :BumonCD)
    @user_type = current_xx_user_id.UserKubun.to_i
    if @record_found
      # 検索成功 → 既存のレコードを表示
    else
      # 検索失敗 → 新規作成
      @xx_ryohi_t = XxRyohiT.new
      @xx_ryohi_t.invoice_number  # ここで連番を付与
    end
    render :new
  end

  def create
    @requests_save = XxRyohiT.new(travel_request_params)
    @requests_save.InsPGID = "C01T001"
    @requests_save.UpdCount = 1
    @requests_save.InsUserID = current_xx_user_id&.UserID || "0000"
    @requests_save.current_role = current_xx_user_id.UserKubun.to_i == 1 ? "employee" : "tako"
    if current_xx_user_id.UserKubun.to_i == 1
      # 空欄ならデフォルト値を入れる
      @requests_save.TehaiiDetail = "返答をお待ちください" if @requests_save.TehaiiDetail.blank?
      @requests_save.Fare = -1 if @requests_save.Fare.nil?
      @requests_save.tax = -1 if @requests_save.tax.nil?
    end
    if @requests_save.save
      # 旅費手配の登録に成功した場合、メールを送信
      redirect_to travel_requests_path, notice: "旅費手配を登録しました"
    else
      @bumon_options = XxmBumon.pluck(:BumonName, :BumonCD)
      @user_type = current_xx_user_id.UserKubun.to_i
      flash.now[:alert] = "旅費手配の登録に失敗しました"
      render :new
    end
  end

  def update
    @requests_update = XxRyohiT.find_by(RefNO: params[:xx_ryohi_t][:RefNO])
    if @requests_update
      @requests_update.assign_attributes(travel_request_params)
      @requests_update.UpdCount += 1
      @requests_update.UpdUserID = current_xx_user_id&.UserID || "0000"
      @requests_update.UpdPGID = "C01T001"
      @requests_update.current_role = current_xx_user_id.UserKubun.to_i == 1 ? "employee" : "tako"
      if @requests_update.save
        # 旅費手配の更新に成功した場合、メールを送信
        redirect_to travel_requests_path, notice: "旅費手配を更新しました"
      else
        flash.now[:alert] = "旅費手配の更新に失敗しました"
        @bumon_options = XxmBumon.pluck(:BumonName, :BumonCD)
        @user_type = current_xx_user_id.UserKubun.to_i
        render :new
      end
    else
      flash.now[:alert] = "旅費手配が見つかりませんでした"
      render :new
    end
  end

  def destroy
    requests_delete = XxRyohiT.find_by(RefNO: params[:id])
    if requests_delete
      if requests_delete.destroy
        redirect_to travel_requests_path, notice: "旅費手配を削除しました"
      else
        redirect_to travel_requests_path, alert: "旅費手配の削除に失敗しました"
      end
    else
      redirect_to travel_requests_path, alert: "旅費手配が見つかりませんでした"
    end
  end
  private

  def travel_request_params
    raw_params = params.require(:xx_ryohi_t)
                      .permit(:RefNO, :RyohiTName, :RyohiDeatil, :UserID, :BumonCD, :Destination, :Sakuban, :KakuteiFlag, :KakuteiDate, :TehaiiDetail, :Fare, :tax, :TKakuteiFlag)
                      .to_h

    raw_params[:BumonID] = raw_params.delete(:BumonCD) if raw_params[:BumonCD]
    raw_params[:ShinseiID] = raw_params.delete(:UserID) if raw_params[:UserID]
    raw_params
  end

end
