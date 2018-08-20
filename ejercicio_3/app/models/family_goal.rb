class FamilyGoal < ApplicationRecord
  has_many :family_goal_attributes, dependent: :destroy
  has_many :users_family_goals
  has_many :users, through: :users_family_goals
end
