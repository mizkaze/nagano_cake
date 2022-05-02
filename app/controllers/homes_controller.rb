class HomesController < ApplicationController

  def top
    @new_arrivals = Item.order(created_at: :desc).limit(4)
  end

  def about
  end


end
