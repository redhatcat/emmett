# Many to many model for Entry and Tag
class TagAssignment < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end

  belongs_to :entry
  belongs_to :tag

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
