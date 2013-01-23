class Product < ActiveRecord::Base
  attr_accessible :image_url, :price, :title
end
