#!/usr/bin/env ruby
#
# Legend of the Sourcerer
# Written by Robert W. Oliver II <robert@cidergrove.com>
# Copyright (C) 2018 Sourcerer, All Rights Reserved.
# Licensed under GPLv3.

module LOTS

MAP_WIDTH = 64
MAP_HEIGHT = 14

MAP_KEY_TREE      = "\u2618"
MAP_KEY_WATER     = "\u2668"
MAP_KEY_GRASS     = "\u2588"
MAP_KEY_MOUNTAIN  = "\u25B2"
MAP_KEY_ENEMY     = "\u263A"
MAP_KEY_SOURCERER = "\u2658"
MAP_KEY_PLAYER    = "\u1330"

# Weighted
MAP_POSSIBLE_KEYS = [
  MAP_KEY_TREE,
  MAP_KEY_TREE,
  MAP_KEY_TREE,
  MAP_KEY_TREE,
  MAP_KEY_WATER,
  MAP_KEY_GRASS,
  MAP_KEY_MOUNTAIN,
  MAP_KEY_ENEMY,
  MAP_KEY_ENEMY
]

# Make grass more common
32.times.each do
  MAP_POSSIBLE_KEYS << MAP_KEY_GRASS
end

MAP_SOURCERER_X = MAP_WIDTH
MAP_SOURCERER_Y = 1

class World

  attr_reader :the_map

  def initialize
    # Set initial world map
    generate_map
  end

  def get_width
    MAP_WIDTH
  end
  
  def get_height
    MAP_HEIGHT
  end
  
  # Return map data in a display format
  def get_map(args)
    player = args[:player]
    buffer = Array.new
    x = 1
    y = 1
    @the_map.each do |row|
      tmp_row = Array.new
      x = 1
      row.each do |col|
        placed = 0
        # Place sourcerer
        if x == MAP_SOURCERER_X and y == MAP_SOURCERER_Y
          tmp_row << MAP_KEY_SOURCERER.colorize(:color => :blue, :background => :light_white)
          placed = 1
        end
        # If player is here, display them
        if x == player.x and y == player.y
          tmp_row << MAP_KEY_PLAYER.colorize(:color => :light_white, :background => :red) 
          placed = 1
        end
        # If we haven't already placed the character, run through the rest of the options
        if placed == 0
	  case col
	    when MAP_KEY_TREE
	      tmp_row << col.colorize(:color => :light_green, :background => :green)
            when MAP_KEY_GRASS
	      tmp_row << col.colorize(:color => :green, :background => :green)
            when MAP_KEY_WATER
	      tmp_row << col.colorize(:color => :white, :background => :blue)
	    when MAP_KEY_MOUNTAIN
	      tmp_row << col.colorize(:color => :yellow, :background => :green)
	    when MAP_KEY_ENEMY
	      tmp_row << col.colorize(:color => :red, :background => :green)
	  end
        end
        x += 1
      end
      buffer << tmp_row
      y += 1
    end
    
    return buffer
  end
	
  # Check the current area on the map and describe it
  def check_area(args)
    player = args[:player]
    ui = args[:ui]
    story = args[:story]
    x = player.x
    y = player.y
    current_area = @the_map[y-1][x-1]
    case current_area
      when MAP_KEY_TREE
        ui.draw_frame({:text => story.area_tree})
      when MAP_KEY_WATER
        ui.draw_frame({:text => story.area_water})
      when MAP_KEY_MOUNTAIN
        ui.draw_frame({:text => story.area_mountain})
      when MAP_KEY_ENEMY
	ui.draw_frame({:text => story.area_enemy})
	return false
    end
    return true
  end

  private

  def new_line
    print "\n"
  end

  # Create a random world map
  def generate_map
    tmp_map = Array.new

    # Step through MAX_HEIGHT times
    MAP_HEIGHT.times do
      tmp_row = Array.new
      MAP_WIDTH.times do
        tmp_row << MAP_POSSIBLE_KEYS.sample
      end

      # Add our assembled row to the map
      tmp_map << tmp_row
      tmp_row = nil
    end
    @the_map = tmp_map

  end

end
end
