class AddUsertoAchievements < ActiveRecord::Migration[7.0]
  def change
    add_column :achievements, :user_id, :integer, after: :id
    add_index :achievements, :user_id
  end
end
