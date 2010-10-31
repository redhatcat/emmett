class EmmettMailer < ActionMailer::Base
  def new_comment(comment)
    @comment = comment
    recipients comment.entry.user.email_address
    subject "New comment on #{comment.entry.name}"
    content_type "text/html"
  end
end
