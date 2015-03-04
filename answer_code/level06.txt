class Player
  MAX_HEALTH = 20

  def play_turn(warrior)
    @health ||= warrior.health

    direction = @backward_completed ? :forward : :backward
    space     = warrior.feel(direction)

    if space.enemy?
      warrior.attack!(direction)
    elsif space.captive?
      warrior.rescue!(direction)
      @backward_completed = true
    elsif space.empty?
      if warrior.health < MAX_HEALTH * 0.5 && under_attack?(warrior)
        warrior.walk!(( direction == :forward ) ? :backward : :forward)
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
end
