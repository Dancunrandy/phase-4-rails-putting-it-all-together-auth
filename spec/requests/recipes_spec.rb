class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if current_user
      # Return all recipes with associated user when logged in
      @recipes = Recipe.all.includes(:user)
    else
      # Return error messages when not logged in
      render json: { errors: ["You must be logged in to see recipes."] }, status: :unauthorized
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      # Return new recipe with associated user when successfully created
      render json: { recipe: @recipe, user: @recipe.user }, status: :created
    else
      # Return validation errors when creation fails
      render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :instructions)
  end
end
