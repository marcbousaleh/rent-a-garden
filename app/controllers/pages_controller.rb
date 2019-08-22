class PagesController < ApplicationController
  def home
    @gardens = Garden.first(10)
  end
end
