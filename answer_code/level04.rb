class Player
  MAX_HEALTH = 20

  def play_turn(warrior)
    @health ||= warrior.health

    space = warrior.feel

    if space.enemy?
      warrior.attack!
    elsif space.empty?
      if (warrior.health < MAX_HEALTH * 0.9) && !(@health > warrior.health)
        warrior.rest!
      else
        warrior.walk!
      end
    end

    @health = warrior.health
  end
end
