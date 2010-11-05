# Model of a blog post tag
class Tag < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    timestamps
  end

  has_many :entries, :through => :tag_assignments
  has_many :tag_assignments, :dependent => :destroy

  default_scope order('name')

  # --- Permissions --- #

  def create_permitted? # :nodoc:
    acting_user.administrator?
  end

  def update_permitted? # :nodoc:
    acting_user.administrator?
  end

  def destroy_permitted? # :nodoc:
    acting_user.administrator?
  end

  def view_permitted?(field) # :nodoc:
    true
  end

end
