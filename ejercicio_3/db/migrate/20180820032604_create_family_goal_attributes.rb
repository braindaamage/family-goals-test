class CreateFamilyGoalAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :family_goal_attributes do |t|
      t.integer :family_goal_id
      t.string :world
      t.string :area
      t.string :position
      t.timestamps
    end
  end
end
