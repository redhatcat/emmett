class Entry < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name            :string
    body_text       :text
    body            :raw_html
    publish_on_date :datetime
    tag_string      :string
    timestamps
  end

  belongs_to :text_format
  belongs_to :user, :creator => true
  has_many :tags, :through => :tag_assignments
  has_many :tag_assignments, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  default_scope order('publish_on_date DESC')

  named_scope :viewable, lambda {|acting_user|
    if !acting_user.administrator?
      {
        :conditions => ["state = 'published' and publish_on_date < ?",
          DateTime.now],
      }
    else
      {}
    end
  }

  lifecycle do
    state :drafted, :default => true
    state :published

    transition :publish, {:drafted => :published}, :available_to => :user
    transition :unpublish, {:published => :drafted}, :available_to => :user
  end

  before_save :format_text
  before_save :save_tags

  def format_text
    if text_format
      begin
        formatter_class = text_format.class_name.constantize
        formatter = formatter_class.new(body_text)
        self.body = formatter.to_html
      rescue => e
        logger.error(
          "Could not format blog entry ##{id} with #{text_format.class_name}:\n#{e}")
      end
    else
      self.body = body_text
    end
  end

  def save_tags
    new_tags = tag_string.split(',').collect{ |name|
      Tag.find_or_create_by_name(name.strip)
    }
    self.tags = new_tags
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
    acting_user.administrator? or (state == 'published' and publish_on_date <= DateTime.now)
  end

end
