class Game < ActiveRecord::Base
  include Tokenable
  tokenable_by 6

  def ensure_only_one_active_game
    # do stuff to ensure a user have only one active game (place holder for game status implementation)
  end
end
