class Player
  MAX_HEALTH = 20

  def play_turn(warrior)
    @health ||= warrior.health

    direction = @backward_completed ? :forward : :backward
    space     = warrior.feel(direction)

    if space.wall?
      warrior.pivot!
      @backward_completed = true
    elsif should_attack?(warrior, direction)
      if (warrior.health < MAX_HEALTH * 0.5 && under_attack?(warrior))
        retreat(warrior, direction)
      else
        warrior.shoot!(direction)
      end
    elsif space.captive?
      warrior.rescue!(direction)
      @backward_completed = true
    elsif space.empty?
      if warrior.health < MAX_HEALTH * 0.5 && under_attack?(warrior)
        retreat(warrior, direction)
      elsif (warrior.health < MAX_HEALTH * 0.9) && !under_attack?(warrior)
        warrior.rest!
      else
        warrior.walk!(direction)
      end
    end

    @health = warrior.health
  end

  def under_attack?(warrior)
    @health > warrior.health
  end

  def retreat(warrior, direction)
     warrior.walk!(( direction == :forward ) ? :backward : :forward)
  end

  def should_attack?(warrior, direction)
    obj = warrior.look(direction).find { |space| !space.empty? }
    obj && obj.enemy?
  end
end
