class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # validates :email, :inclusion => { :in => RegisteredUser.all.collect(&:email), :message => " is not registered with us" }
  validate :email_registered_or_not
  has_many :attempts, dependent: :destroy
  has_many :evaluations, :through => :attempts, dependent: :destroy

  def attempted_evaluations
  	attempts.pluck(:evaluation_id, :unfinished).map do |arr| Hash.send(:[], *arr) end.reduce({}, :merge)
  end

  def email_registered_or_not
    if RegisteredUser.present?
      unless RegisteredUser.all.collect(&:email).include?(email)
        errors.add(:email,"is not registered with us")
      end
    end
  end
end
