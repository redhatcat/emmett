class CreateTagsAndComments < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :comments do |t|
      t.text     :body
      t.boolean  :is_public
      t.string   :posted_from_ip
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :entry_id
    end
    add_index :comments, [:user_id]
    add_index :comments, [:entry_id]

    create_table :tag_assignments do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :entry_id
      t.integer  :tag_id
    end
    add_index :tag_assignments, [:entry_id]
    add_index :tag_assignments, [:tag_id]

    add_column :entries, :publish_on_date, :datetime
    add_column :entries, :tag_string, :string
    add_column :entries, :user_id, :integer

    add_index :entries, [:user_id]
  end

  def self.down
    remove_column :entries, :publish_on_date
    remove_column :entries, :tag_string
    remove_column :entries, :user_id

    drop_table :tags
    drop_table :comments
    drop_table :tag_assignments

    remove_index :entries, :name => :index_entries_on_user_id rescue ActiveRecord::StatementInvalid
  end
end
