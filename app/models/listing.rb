class Listing < ActiveRecord::Base
  belongs_to :district
  belongs_to :dwelling_kind
end