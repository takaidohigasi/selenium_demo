class Player
  def play_turn(warrior)
    space = warrior.feel
    
    if space.enemy?
      warrior.attack!
    elsif space.empty?
      warrior.walk!
    end
  end
end
