class AddLifecycleToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :state, :string, :default => "drafted"
    add_column :entries, :key_timestamp, :datetime

    add_index :entries, [:state]
  end

  def self.down
    remove_column :entries, :state
    remove_column :entries, :key_timestamp

    remove_index :entries, :name => :index_entries_on_state rescue ActiveRecord::StatementInvalid
  end
end
