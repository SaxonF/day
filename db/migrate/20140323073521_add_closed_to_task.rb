class AddClosedToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :closed, :boolean, default: false
  end
end
