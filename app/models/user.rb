class User < ActiveRecord::Base
  has_many :durations, dependent: :destroy
  has_many :bulks, dependent: :destroy
end
