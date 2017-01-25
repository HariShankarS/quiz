class Evaluation < ActiveRecord::Base
 has_many :questions, dependent: :destroy
 has_many :attempts
 has_many :users, through: :attempts
end
