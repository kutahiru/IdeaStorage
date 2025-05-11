class CategoriesController < ApplicationController
  def index
    @categories = curret_user.categories
  end
end
