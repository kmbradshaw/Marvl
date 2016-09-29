class Location < ApplicationRecord
  belongs_to :organisation

  def full_address
    self.street_address + ",   " + self.city + ", " + self.state + ", " + self.zip_code.to_s
  end

end
