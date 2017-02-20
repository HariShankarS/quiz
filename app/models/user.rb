class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # validates :email, :inclusion => { :in => RegisteredUser.all.collect(&:email), :message => " is not registered with us" }
  # validate :email_registered_or_not
  # validates_uniqueness_of :referral_code
  validate :referral_code_check
  has_many :attempts, dependent: :destroy
  has_many :evaluations, :through => :attempts, dependent: :destroy
  attr_accessor :referral_code 

  def attempted_evaluations
  	attempts.pluck(:evaluation_id, :unfinished).map do |arr| Hash.send(:[], *arr) end.reduce({}, :merge)
  end

  # def email_registered_or_not
  #   if RegisteredUser.present?
  #     unless RegisteredUser.all.collect(&:email).include?(email)
  #       errors.add(:email,"is not registered with us")
  #     end
  #   end
  # end

  def referral_code_check
    if Referral.present?
      unless Referral.where(code: referral_code).where("expiry_date > ?",Time.now).present?
        errors.add(:referral_code,"is not a valid one")
      end
    end
  end
end
