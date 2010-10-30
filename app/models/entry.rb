class Entry < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name      :string
    body_text :text
    body      :raw_html
    timestamps
  end

  belongs_to :text_format

  before_save :format_text

  def format_text
    if text_format
      begin
        logger.debug("Applying #{text_format.name} to entry ##{id}")
        formatter_class = text_format.class_name.constantize
        formatter = formatter_class.new(body_text)
        self.body = formatter.to_html
      rescue => e
        logger.error(
          "Could not format blog entry with #{text_format.class_name}:\n#{e}")
      end
    else
      self.body = body_text
    end
    logger.debug(self.body)
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
