class Admin::SearchController < ApplicationController
  before_action :authenticate_admin!

  def search
    @content = params["search"]["content"]
    @method = params["search"]["method"]
    @records = search_for(@content, @method).page(params[:page]).per(10)
  end

  private

  def search_for(content, method)
	  if method == 'perfect'
	    User.where(name: content )
	  elsif  method == 'forward'
	    User.where('name LIKE ?' , content+'%' )
	  elsif  method == 'backward'
	    User.where('name LIKE ?' ,'%'+content )
	  else
	    User.where('name LIKE ?' , '%'+content+'%' )
	  end
  end
end
