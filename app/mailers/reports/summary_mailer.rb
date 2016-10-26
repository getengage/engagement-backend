class Reports::SummaryMailer < ActionMailer::Base
  def notify(emails, data)
    kit = PDFKit.new(render_to_string("pdf/report_summary", layout: "print", locals: data))
    kit.stylesheets << File.join(Rails.root + "app/assets/stylesheets/print.css")
    attachments["report_summary.pdf"] = kit.to_pdf
    mail(to: "no-reply@example.com",
         from: "no-reply@example.com",
         bcc: emails)
  end
end