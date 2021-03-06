# Model of a blog comment
class Comment < ActiveRecord::Base
  include Rakismet::Model # Must go first.
  # Hobo makes all following mixin InstanceMethods private for some reason.
  hobo_model

  fields do
    body           :text, :required, :primary_content => true
    is_public      :boolean
    posted_from_ip :string
    timestamps
  end

  belongs_to :user, :creator => true, :accessible => false
  belongs_to :entry, :accessible => true

  before_create :check_for_spam
  after_create :notify_entry_user

  rakismet_attrs :author => proc { user.name },
                 :author_email => proc { user.email_address },
                 :comment_type => 'comment',
                 :user_ip => :posted_from_ip,
                 :content => :body

  # Ask akismet if this comment is spam and set is_public to false if it is.
  # This is a before_create filter
  def check_for_spam
    self.is_public = !self.spam?
  end

  # Send an email to the post's author after a new comment is made.
  # This is an after_create filter.
  def notify_entry_user
    EmmettMailer.deliver_new_comment(self)
  end

  # --- Permissions --- #

  def create_permitted? # :nodoc:
    acting_user.signed_up?
  end

  def update_permitted? # :nodoc:
    acting_user.administrator?
  end

  def destroy_permitted? # :nodoc:
    acting_user.administrator?
  end

  def view_permitted?(field) # :nodoc:
    if self.is_public
      true
    else
      acting_user.administrator? or user_is? acting_user
    end
  end

end
