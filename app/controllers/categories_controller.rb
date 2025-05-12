class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    binding.pry
  end
end
