class TravelRequestMailer < ApplicationMailer
  def notify_tako(request)
    @request = request
    mail(to: "tako@example.com", subject: "【確認依頼】手配内容の確認をお願いします")
  end

  def confirm_to_employee(request)
    @request = request
    mail(to: "employee@example.com", subject: "【確定】伝票No: #{@request.RefNO} が確定しました")
  end
end
