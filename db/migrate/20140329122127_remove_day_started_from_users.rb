class RemoveDayStartedFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :day_started, :boolean
  end
end
