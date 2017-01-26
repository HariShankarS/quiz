class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, :inclusion => { :in => RegisteredUser.all.collect(&:email), :message => " is not registered with us" }
  has_many :attempts, dependent: :destroy
  has_many :evaluations, :through => :attempts, dependent: :destroy

  def attempted_evaluations
  	attempts.pluck(:evaluation_id)
  end
end
