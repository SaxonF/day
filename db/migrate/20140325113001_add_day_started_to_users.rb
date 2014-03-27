class AddDayStartedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :day_started, :boolean, defalt: false
  end
end
