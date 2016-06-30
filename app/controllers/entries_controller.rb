class EntriesController < ApplicationController
  def new
  	@entry = Entry.new
  end

  def create
  	@entry = Entry.create(entry_params)
  	@zip = @entry.zip
  	@provider = @entry.provider
  	@usage = @entry.monthly_energy_usage
  	@heating_usage = params[:entry][:fuel_usage].to_f

  	@providers = RateProvider.where(zip: @zip)
  	@subregion = ZipSubregion.find_by_zip(@zip)
  	#@rate = RateProvider.where(zip: @zip).first
  	if (@rate = RateProvider.where('zip = ? AND provider = ?', params[:entry][:zip], params[:entry][:provider]).first)
  		@bill = @usage * @rate.rate
  		@reduced = @usage * (1 - (0.164 * 0.8))
  		@heating_reduced = @heating_usage * 0.88


    else
  	 @error = "no providers available"
  
  	end
  	# } else {
  	# 	redirect_to root_path
  	# }


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
