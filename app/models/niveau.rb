class Niveau < ActiveRecord::Base

  validates_presence_of :nom, :code
  validates_numericality_of :code

end
