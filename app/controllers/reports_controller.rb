class ReportsController < ApplicationController
  def index
    @reports = XxRyohiT.all
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date]) rescue nil
      end_date = Date.parse(params[:end_date]) rescue nil

      if start_date && end_date
        if params[:include_unconfirmed] == "1"
          # 確定済み＋未確定を表示（期間フィルターは確定済みにだけ適用）
          @reports = @reports.where(
            "(KakuteiFlag = ? AND TKakuteiFlag = ? AND KakuteiDate BETWEEN ? AND ?) OR (KakuteiFlag != ? OR TKakuteiFlag != ?)",
            "0", "0", start_date, end_date, "0", "0"
          )
        else
          # 確定済みのみ（両方0）
          @reports = @reports.where(
            KakuteiFlag: "0", TKakuteiFlag: "0"
          ).where(KakuteiDate: start_date..end_date)
        end
      end
    else
      if params[:include_unconfirmed] != "1"
        # 日付なしで確定済みのみ表示
        @reports = @reports.where(KakuteiFlag: "0", TKakuteiFlag: "0")
      end
      # チェックがあればそのまま全部出す（条件なし）
    end
    respond_to do |format|
      format.html
      format.xlsx { response.headers['Content-Disposition'] = "attachment; filename=旅費一覧.xlsx" }
    end
  end
end
