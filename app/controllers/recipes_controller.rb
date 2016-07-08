class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    ingredients_params[:ingredients_attributes].values.each do |param|
      @recipe.ingredients << Ingredient.new(param) unless @recipe.ingredients.include?(Ingredient.new(param))
    end
    @recipe.save
    redirect_to @recipe
  end

  def recipe_params
    params.require(:recipe).permit(:title)
  end

  def ingredients_params
    params.require(:recipe).permit(:ingredients_attributes => [:name, :quantity])
  end
end
