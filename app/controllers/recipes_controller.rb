class RecipesController < ApplicationController
    before_action :require_login, only: [:index, :create]
  
    def index
      recipes = Recipe.all
      render json: recipes, include: [:user], except: [:created_at, :updated_at], status: :ok
    end
  
    def create
      recipe = current_user.recipes.build(recipe_params)
      if recipe.save
        render json: recipe, include: [:user], except: [:created_at, :updated_at], status: :created
      else
        render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def require_login
      unless current_user
        render json: { errors: ["You must be logged in to access this feature"] }, status: :unauthorized
      end
    end
  
    def recipe_params
      params.require(:recipe).permit(:title, :instructions, :minutes_to_complete)
    end
  end
  