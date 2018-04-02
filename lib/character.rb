#!/usr/bin/env ruby
#
# Legend of the Sourcerer
# Written by Robert W. Oliver II <robert@cidergrove.com>
# Copyright (C) 2018 Sourcerer, All Rights Reserved.
# Licensed under GPLv3.

module LOTS

ENEMY_KILLED = "KILLED"

HIT_CHANCE_MODIFIER = 5
ATTACK_VALUE_MODIFIER = 1

class Character
  
  attr_accessor :name
  attr_accessor :health
  attr_accessor :mana
  attr_accessor :x
  attr_accessor :y
  attr_accessor :level
  attr_accessor :str
  attr_accessor :int
  attr_accessor :in_combat
  attr_accessor :current_enemy
  attr_accessor :lines
  attr_accessor :dead

  def initialize (args)
    name = args[:name]
    world = args[:world]
    @name = name
    @level = 1
    @health = 100
    @mana = 100
    @str = 5
    @int = 5
    @x = 1
    @y = world.get_height
    @in_combat = false
    @current_enemy = nil
    @lines = 0
    @dead = 0
    return "Welcome %{name}! Let's play Legend of the Sourcerer!"
  end

  # Player attacks enemy
  def attack(args)
    player = self
    enemy = args[:enemy]
    
    # Does the player even hit the enemy?
    # We could use a hit chance stat here, but since we don't have one,
    # we'll just base it off the player/enemy stength discrepency.
    puts player.inspect
    puts enemy.inspect
    str_diff = (player.str - enemy.str) * 2
    hit_chance = rand(1...100) + str_diff + HIT_CHANCE_MODIFIER

    if (hit_chance > 50)
      # Determine value of the attack
      attack_value = rand(1...player.str) + ATTACK_VALUE_MODIFIER
      if attack_value > enemy.health
	print "You swing and " + "hit".light_yellow + " the " + enemy.name.light_red + " for " + attack_value.to_s.light_white + " damage, killing it!\n"
	print "You gain " + enemy.lines.to_s.light_white + " lines of code.\n"
	return ENEMY_KILLED
      else
	print "You swing and " + "hit".light_yellow + " the " + enemy.name.light_red + " for " + attack_value.to_s.light_white + " damage!\n"
	return attack_value
      end
    else
      print "You swing and " + "miss".light_red + " the " + enemy.name + "!\n"
      return 0
    end
    return true
  end
	
  def move(args)
    direction = args[:direction]
    world = args[:world]
    ui = args[:ui]
    story = args[:story]
    case direction
      when :up
        if @y > 1
	  @y -= 1
	else
	  ui.out_of_bounds
	  return false
	end
      when :down
        if @y < world.get_height
	  @y += 1
	else
	  ui.out_of_bounds
	  return false
	end
      when :left
        if @x > 1
	  @x -= 1
	else
	  ui.out_of_bounds
	  return false
	end
      when :right
        if @x < world.get_width
	  @x += 1
	else
	  ui.out_of_bounds
	  return false
	end
      end
    unless world.check_area({:player => self, :ui => ui, :story => story})
      return false
    else
      return true
    end
  end
  
end

end
