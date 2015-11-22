class Game < ActiveRecord::Base
  include Tokenable
  tokenable_by 6
end
