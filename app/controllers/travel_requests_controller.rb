class TravelRequestsController < ApplicationController
  def new
    @travel_request = XxRyohiT.new
    @bumon_options = XxmBumon.pluck(:BumonName, :BumonCD)
    
  end

  def index
    @travel_requests = XxRyohiT.all
  end

  def search
    keyword = params[:query].to_s.strip
    @xx_ryohi_t = XxRyohiT.find_by(RefNO: keyword)
    @record_found = @xx_ryohi_t.present?
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
  end
  def update
  end
  def destroy
  end
  private
  def travel_request_params
    params.require(:xx_ryohi_t)
          .permit(:RefNO, :invoice_number, :UserID, :TravelDate, :Destination, :Purpose, :Amount, :Remarks)
  end
end
