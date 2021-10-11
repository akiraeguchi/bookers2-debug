class HomesController < ApplicationController
  def top
    if user_signed_in?
      @user = current_user.id
    end
  end

  def about
  end

end
