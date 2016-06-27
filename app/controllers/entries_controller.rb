class EntriesController < ApplicationController
  def new
  	@time = Time.now
  	@entry = Entry.new
  end

  def create
  	@entry = Entry.create(entry_params)
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
