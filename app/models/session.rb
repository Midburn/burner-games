class Session < ActiveRecord::Base
  include Tokenable
  tokenable_by 22
end
