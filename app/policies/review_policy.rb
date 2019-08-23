class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def update?
    true
  end

  def create?
    # true unless Booking.all.select { |b| b.renter_id == user }.count.zero?
    true
  end

  def destroy?
    true
  end

  private

  def user_is_owner?
    true
  end
end
