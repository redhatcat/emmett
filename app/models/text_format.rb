# Model of a blog entry text format
class TextFormat < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name       :string
    class_name :string
    timestamps
  end

  has_many :entries

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
