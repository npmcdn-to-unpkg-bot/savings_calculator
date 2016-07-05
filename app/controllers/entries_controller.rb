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

  	@subregion = ZipSubregion.find_by_zip(@zip)

  	#Fuel information
  	@fuel = FuelCost.find_by_fuel_type(@fuel_type)
  	@heating_rate = @fuel.cost
  	@raw_heating_emissions = @fuel.emissions
  	@emission_conversion = @fuel.conversion
  	@sr_emissions = SubregionEmission.find_by_acronym(@subregion.primary_sub)

  	#If provider serves zip continue, else print error
  	if (@rate = RateProvider.where('zip = ? AND provider = ?', params[:entry][:zip], params[:entry][:provider]).first)

  		#Calculating total bill
  		@electric_bill = @electric_usage * @rate.rate
  		@heating_bill = @heating_usage * @heating_rate
  		@total_bill = @electric_bill + @heating_bill

  		#Calculating reduced electric bill
  		@electric_reduced = @electric_usage * (1 - (0.164 * 0.8))
  		@reduced_electric_bill = @electric_reduced * (@rate.rate + 0.015)

  		#Calculating reduced heating bill
  		@heating_reduced = @heating_usage * 0.88
  		@reduced_heating_bill = @heating_reduced * @heating_rate

  		#Total savings
  		@total_reduced_bill = @reduced_electric_bill + @reduced_heating_bill
  		@total_savings = @total_bill - @total_reduced_bill


  		#Calculating reduced emissions
  		@electric_emissions = (@electric_usage * @sr_emissions.emissions) / 1000
  		@reduced_electric_emissions = ((@electric_reduced * @sr_emissions.emissions) / 1000)
  		@heat_emissions = @raw_heating_emissions * @heating_usage * @emission_conversion
  		@reduced_heat_emissions =  @raw_heating_emissions * @heating_reduced * @emission_conversion

  		#Total reductions in emissions
  		@total_emissions = @electric_emissions + @heat_emissions
  		@reduced_emissions = @reduced_electric_emissions + @reduced_heat_emissions
  		@emission_reduction = @total_emissions - @reduced_emissions
  		@trees_planted = ((@emission_reduction * 12) / 2204.62) / 0.039

  		

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

  def rate_providers 
    @providers = RateProvider.where(zip: params[:zip].to_i)
  end

	private

	def entry_params
		params.require(:entry).permit(:monthly_energy_usage, :zip, :provider, :fuel_type, :fuel_usage)
	end
end
