class User < ApplicationRecord
  has_one :users_family_goal
  has_one :family_goal, through: :users_family_goal

  after_update :after_user_update
  after_create :set_family_goal

  def update_family_goal
    family_goal_attribute = FamilyGoalAttribute.find_by(world: world, area: area, position: position)

    if !family_goal_attribute.nil?
      self.update family_goal: family_goal_attribute.family_goal
    else
      self.update family_goal: nil
    end
  end

  private

    def after_user_update
      set_family_goal unless previous_changes.empty?
    end

    def set_family_goal
      update_family_goal
    end
end
