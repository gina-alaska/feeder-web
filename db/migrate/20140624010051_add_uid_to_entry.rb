class AddUidToEntry < ActiveRecord::Migration
  def up
    add_column :entries, :uid, :bigint

    Entry.where(aasm_state: 'finished').each do |e|
      e.aasm_state = 'waiting'
      e.finish
    end
  end

  def down
    remove_column :entries, :uid
  end
end
