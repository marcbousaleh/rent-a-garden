class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(renter: user)
    end
  end

  def create?
    true
  end
end
