class EntriesController < ApplicationController
  def new
  	@entry = Entry.new
  end

  def create
  	@entry = Entry.create(entry_params)
  	@zip = @entry.zip
  	@provider = @entry.provider
  	@providers = RateProvider.where(zip: @zip)
  	@subregion = ZipSubregion.find_by_zip(@zip)
  	# @rate = RateProvider.find_by_provider(@provider)

  	if @entry.persisted?
			flash.now[:success] = "Your entry was recorded!"
		else
			flash.now[:danger] = "Entry not accepted."
			render 'new'
		end
	end

	private

	def entry_params
		params.require(:entry).permit(:monthly_energy_usage, :zip, :provider)
	end
end
