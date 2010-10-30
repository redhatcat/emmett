class Comment < ActiveRecord::Base

  hobo_model # Don't put anything above this

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

  def check_for_spam
    #TODO self.is_public = !self.spam?
    self.is_public = true
  end

  def notify_entry_user
    # TODO EmmettMailer.deliver_new_comment(self)
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    if self.is_public
      true
    else
      acting_user.administrator? or user_is? acting_user
    end
  end

end
