class AddIndexesToEntries < ActiveRecord::Migration
  def change
    add_index :entries, :feed_id
    add_index :entries, :aasm_state
    add_index :entries, :uid
    add_index :entries, [:feed_id, :aasm_state]
    add_index :entries, [:feed_id, :aasm_state, :uid]
  end
end
