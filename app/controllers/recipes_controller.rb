class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.includes(:reviews).search(params[:search]).by_difficulty(params[:difficulty])
    @recipe_count = Rails.cache.fetch("recipe_count", expires_in: 10.minutes) { Recipe.count }
  end

  def show
    @review = Review.new
  end

  def new
    @recipe = Recipe.new
    3.times { @recipe.ingredients.build }
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      Rails.cache.delete("recipe_count")
      redirect_to @recipe, notice: "Recipe was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    Rails.cache.delete("recipe_count")
    redirect_to recipes_url, notice: "Recipe was successfully deleted."
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name, :description, :difficulty, :prep_time_minutes,
      :cook_time_minutes, :servings, :image_url,
      ingredients_attributes: [ :id, :name, :quantity, :unit, :_destroy ]
    )
  end
end
