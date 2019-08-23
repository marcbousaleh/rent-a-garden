class ReviewsController < ApplicationController
  def create
    @garden = Garden.find(params[:garden_id])
        @review = Review.new(review_params)
        @review.garden = @garden
    authorize @review

        if @review.save
          respond_to do |format|
            format.html { redirect_to garden_path(@garden) }
            format.js  # <-- will render `app/views/reviews/create.js.erb`
          end
        else
          respond_to do |format|
            format.html { render 'gardens/show' }
            format.js  # <-- idem
          end
        end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
