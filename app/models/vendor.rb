class Vendor < ApplicationRecord
  has_many :offerings
  has_many :categories, through: :offerings
  has_many :reviews

  validates :name, uniqueness: true
  validates :name, presence: true

  def full_address
  	self.street_address + " " + self.city + " " + self.state + " " + self.zip_code.to_s
  end

  def avg_rating
    avg_rating = 0
    reviews_ratings_array = self.reviews.map { |r| r.rating }
    if self.reviews.count > 0
      avg_rating = self.reviews.map { |r| r.rating }.reduce(0, :+) / self.reviews.count.to_f
      avg_rating = avg_rating.round(1)
      avg_rating
    else
  	  "n/a"
    end
  end

  def associate_category(string_or_category)
    if string_or_category.class == Category
      category = string_or_category
    else
      category = Category.find_or_create_by name: string_or_category
    end
    if category
      Offering.create vendor_id: self.id, category_id: category.id
    end

  end
end
