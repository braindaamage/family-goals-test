class UsersFamilyGoal < ApplicationRecord
  belongs_to :user
  belongs_to :family_goal
end
