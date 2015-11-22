module Tokenable
  extend ActiveSupport::Concern

  included do
    validates :token, presence: true, length: { maximum: 255 }, uniqueness: true
    before_validation :set_token, if: -> { new_record? && token.blank? }
  end

  module ClassMethods
    def tokenable_by(length)
      define_method :set_token do
        self.token = loop do
          new_token = SecureRandom.urlsafe_base64(length).tr("-_", "xy")[0..length - 1]
          break new_token unless self.class.where(token: new_token).exists?
        end
      end
    end
  end
end

