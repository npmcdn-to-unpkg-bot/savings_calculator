class EntriesController < ApplicationController
  def new
  	@entry = Entry.new
  end

  def create
  	@entry = Entry.create(entry_params)
  	@zip = @entry.zip
  	@provider = @entry.provider
  	@electric_usage = @entry.monthly_energy_usage
  	@heating_usage = @entry.fuel_usage
  	@fuel_type = @entry.fuel_type

  	@providers = RateProvider.where(zip: @zip)
  	@subregion = ZipSubregion.find_by_zip(@zip)
  	@heating_rate = FuelCost.find_by_fuel_type(@fuel_type).cost
  	@sr_emissions = SubregionEmission.find_by_acronym(@subregion.primary_sub)

  	if (@rate = RateProvider.where('zip = ? AND provider = ?', params[:entry][:zip], params[:entry][:provider]).first)
  		@electric_bill = @electric_usage * @rate.rate
  		@heating_bill = @heating_usage * @heating_rate
  		@total_bill = @electric_bill + @heating_bill



  		@electric_reduced = @electric_usage * (1 - (0.164 * 0.8))
  		@heating_reduced = @heating_usage * 0.88
  		@reduced_electric_bill = @electric_reduced * (@rate.rate + 0.015)
  		@reduced_heating_bill = @heating_reduced * @heating_rate
  		@total_reduced_bill = @reduced_electric_bill + @reduced_heating_bill
  		@total_savings = @total_bill - @total_reduced_bill
  		@heat_emissions = FuelCost.find_by_fuel_type(@fuel_type).emissions * @heating_usage * FuelCost.find_by_fuel_type(@fuel_type).conversion
  		@reduced_heat_emissions = FuelCost.find_by_fuel_type(@fuel_type).emissions * @heating_reduced * FuelCost.find_by_fuel_type(@fuel_type).conversion
  		@total_emissions = ((@electric_usage * @sr_emissions.emissions) / 1000) + @heat_emissions
  		@reduced_emissions = ((@electric_reduced * @sr_emissions.emissions) / 1000) + @reduced_heat_emissions
  		@emission_reduction = @total_emissions - @reduced_emissions

  		

    else
  	 @error = "no providers available"
  	end

  	if @entry.persisted?
			flash.now[:success] = "Your entry was recorded!"
		else
			flash.now[:danger] = "Entry not accepted."
			render 'new'
		end
	end

	private

	def entry_params
		params.require(:entry).permit(:monthly_energy_usage, :zip, :provider, :fuel_type, :fuel_usage)
	end
end
