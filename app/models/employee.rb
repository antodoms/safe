class Employee < ActiveRecord::Base

belongs_to :users
has_many :tweets
#validates :score, :name, :handle, :tweet, :create


end