class EmmettMailer < ActionMailer::Base
  def new_comment(comment)
    @comment = comment
    settings = YAML::load(File.open("#{RAILS_ROOT}/config/emmett.yml"))
    from settings["email_from"]
    recipients comment.entry.user.email_address
    subject "New comment on #{comment.entry.name}"
    content_type "text/html"
  end
end
