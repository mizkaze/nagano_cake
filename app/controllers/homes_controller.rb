class HomesController < ApplicationController

  def top
    @new_arrival = Item.order(created_at: :desc).limit(4)
  end

  def about
  end


end
