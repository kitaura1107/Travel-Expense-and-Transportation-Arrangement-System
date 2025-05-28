class XxRyohiT < ApplicationRecord
   belongs_to :xxm_bumon, foreign_key: 'BumonID', primary_key: 'BumonCD', optional: true

  def invoice_number
    self.set_travel_id
  end

  private

  def set_travel_id
    today_prefix = Date.today.strftime("%Y%m%d")
    latest = XxRyohiT.where("RefNO LIKE ?", "#{today_prefix}%")
                     .order(RefNO: :desc)
                     .limit(1)
                     .pluck(:RefNO)
                     .first

    next_number = if latest.present?
                    latest[-3..].to_i + 1
                  else
                    1
                  end

    self.RefNO = today_prefix + next_number.to_s.rjust(3, '0')
  end
end
