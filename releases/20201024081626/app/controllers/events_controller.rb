class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(user_id: current_user)
  end
end
