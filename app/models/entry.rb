class Entry < ActiveRecord::Base
	validates :zip, presence: true
	validates :monthly_energy_usage, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
	validates :provider, presence: true
	validates :fuel_usage, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
	validates :fuel_type, presence: true
end
