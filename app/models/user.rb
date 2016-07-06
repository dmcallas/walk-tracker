class User < ActiveRecord::Base
  has_many :durations, dependent: :destroy
end
