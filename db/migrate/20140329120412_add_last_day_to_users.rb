class AddLastDayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_day, :datetime
  end
end
