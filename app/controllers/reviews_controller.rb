class ReviewsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = @recipe.reviews.build(review_params)

    if @review.save
      redirect_to @recipe, notice: "Review was successfully submitted."
    else
      render "recipes/show", status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:author_name, :rating, :comment)
  end
end
