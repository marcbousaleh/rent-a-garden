class GardenPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end


  def my_gardens?
    record.all? { |garden| garden.owner == user }
  end

  def show?
    true
  end

  def update?
    user_is_owner?
  end

  def create?
    true
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_is_owner?
    record.owner == user
  end
end
