class CreateUsersFamilyGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :users_family_goals do |t|
      t.references :user
      t.references :family_goal
    end
  end
end
