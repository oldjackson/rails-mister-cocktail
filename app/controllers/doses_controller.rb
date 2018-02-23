class DosesController < ApplicationController
  def create
    @dose = Dose.new(dose_params)
    # dose_params does NOT contain the reference to the cocktail (see below),
    # and we have to add it manually
    @cocktail = Cocktail.find(params[:cocktail_id]) # :cocktail_id is added by the 2-arguments simple_form in views/doses/_form
    @dose.cocktail = @cocktail

    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render "cocktails/show"
    end
  end

  def destroy
    dose = Dose.find(params[:id])
    @cocktail = dose.cocktail # to render the show view afterwards
    dose.destroy
    @dose = Dose.new # to render the show view afterwards
    render "cocktails/show"
  end

  def dose_params
    # The following does NOT work as :cocktail_id is not in params[:dose]
    # params.require(:dose).permit(:description, :ingredient_id, :cocktail_id)

    # The following DOES work because :ingredient_id is in the same hash as :description in params[:dose]
    # thanks to the <%= f.association :ingredient%> in the simple_form in views/doses/_form
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
