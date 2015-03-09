class Location < ActiveRecord::Base
  def city_and_state
    "#{city}, state"
  end
end
