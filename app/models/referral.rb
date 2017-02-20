class Referral < ActiveRecord::Base
  validates_uniqueness_of :code
  validates_presence_of :code, :expiry_date
end
