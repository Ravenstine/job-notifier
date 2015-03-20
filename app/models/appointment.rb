class Appointment < ActiveRecord::Base
  belongs_to :user
  def in_words
    "#{name} with #{person} from #{company} at #{time}"
  end
end
