class Reports::SummaryMailer < ActionMailer::Base
  layout "email"

  def notify(emails, data, name)
    attachments.inline["logo.png"] = File.read("#{Rails.root.to_s + '/app/assets/images/engage-logo-multicolor-masked-dark.png'}")
    @name = name
    kit = PDFKit.new(render_to_string("pdf/report_summary", layout: "print", locals: data))
    kit.stylesheets << File.join(Rails.root + "app/assets/stylesheets/print.css")
    attachments["report_summary.pdf"] = kit.to_pdf
    mail(to: "no-reply@example.com",
         from: "no-reply@example.com",
         subject: "Report Summary for #{name}",
         bcc: emails)
  end
end