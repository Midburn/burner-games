class Session < ActiveRecord::Base
  
  # concerns
  include Tokenable
  tokenable_by 22

  # assosiations
  belongs_to :game

  # callbacks
  before_validation :set_expiration, if: -> { new_record? && expiration.blank? }

  def set_expiration
    self.expiration = DateTime.now + 2.hours
  end
end