class AddTimeSpentToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :time_spent, :integer
  end
end
