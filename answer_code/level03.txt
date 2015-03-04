class Player
  MAX_HEALTH = 20

  def play_turn(warrior)
    space = warrior.feel

    if space.enemy?
      warrior.attack!
    elsif space.empty?
      if (warrior.health < MAX_HEALTH * 0.9)
        warrior.rest!
      else
        warrior.walk!
      end
    end
  end
end
