class CreateEntriesAndTextFormats < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string   :name
      t.text     :body_text
      t.text     :body
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :text_format_id
    end
    add_index :entries, [:text_format_id]

    create_table :text_formats do |t|
      t.string   :name
      t.string   :class_name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :entries
    drop_table :text_formats
  end
end
