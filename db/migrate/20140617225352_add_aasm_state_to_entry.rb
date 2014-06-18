class AddAasmStateToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :aasm_state, :string
  end
end
