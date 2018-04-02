#!/usr/bin/env ruby
#
# Legend of the Sourcerer
# Written by Robert W. Oliver II <robert@cidergrove.com>
# Copyright (C) 2018 Sourcerer, All Rights Reserved.
# Licensed under GPLv3.
#
# UI Class
#

module LOTS

UI_FRAME_HORIZONTAL = "\u2501"
UI_FRAME_VERTICAL = "\u2503"
UI_FRAME_UPPER_LEFT = "\u250F"
UI_FRAME_LOWER_LEFT = "\u2517"
UI_FRAME_UPPER_RIGHT = "\u2513"
UI_FRAME_LOWER_RIGHT = "\u251B"

UI_COPYRIGHT = "\u00A9"
UI_EMAIL = "\u2709"

class UI

  # Clear the screen
  def clear
    print "\e[H\e[2J"
  end

  def display_map(args)
    map = args[:map]
    new_line
    draw_frame({:text => map})
    new_line
  end

  # Ask user a question. A regular expression filter can be applied.
  def ask(question, filter = nil)
    if filter
      match = false
      answer = nil
      while match == false
        print "\u2712 ".red + question.light_white + " "
        answer = gets.chomp
	    if answer.match(filter)
	      return answer
        else
          print "Sorry, please try again.".red
          new_line
          new_line
        end
      end
    else
      print "\u2712 ".red + question.light_white + " "
      return gets.chomp
    end
  end
  
  # Display welcome
  def welcome
    text = Array.new
    text << "Legend of the Sourcerer".light_green
    text << "Written by Robert W. Oliver II ".white + UI_EMAIL.light_white + " robert@cidergrove.com".white
    text << "Copyright " + UI_COPYRIGHT + " Sourcerer, All Rights Reserved.".white
    text << "Licensed under GPLv3.".white
    draw_frame({:text => text})
    new_line
  end

  # Prints a new line. Optinally can print multiple lines.
  def new_line(times = 1)
    times.times do
      print "\n"
    end
  end

  # Draw text surrounded in a nice frame
  def draw_frame(args)
    # Figure out width automatically
    text = args[:text]
    width = get_max_size_from_array(text)
    draw_top_frame(width)
    text.each do |t|
      t_size = get_real_size(t)
      draw_vert_frame_begin
      if t.kind_of?(Array)
        t.each do |s|
          print s
        end
      else
        print t
      end
      (width - (t_size + 4)).times do
        print " " 
      end
      draw_vert_frame_end
      new_line
    end
    draw_bottom_frame(width)
  end

  def display_version
    puts "This is " + "Legend of the Sourcerer".light_red + " Version " + LOTS_VERSION.light_white
    new_line
  end
  
  def not_found
    print "Command not understood. Please try again.".red
    new_line
  end
	
  def show_location(args)
    player = args[:player]
    print "You are currently on row " + player.y.to_s.light_white + ", column " + player.x.to_s.light_white
    new_line
    print "Use the " + "map".light_white + " command to see the map."
    new_line
  end
 
  def cannot_travel_combat
    puts "You are in combat and cannot travel!"
  end

  def not_in_combat
    puts "You are not in combat."
  end

  def quit
    new_line
    print "You abandoned your journey.".red
    new_line(2)
  end
  
  def get_cmd
    print "Type ".white + "help".light_white + " for possible commands.\n"
    print "\u2712 ".red + "Your command? ".light_white
    return gets.chomp.downcase
  end
	
  def out_of_bounds
    print "x".red + " Requested move out of bounds."
    new_line
  end
  
  def display_name(args)
    player = args[:player]
    print "You are " + player.name.light_white + ". Have you forgotten your own name?"
    new_line    
  end
  
  def player_dead(args)
    story = args[:story]
    new_line
    text = story.player_dead
    draw_frame(:text => text)
    new_line
  end

  def enemy_greet(args)
    enemy = args[:enemy]
    print enemy.name.light_white + " attacks!"
    new_line
    new_line
  end

  private
  
  def draw_vert_frame_begin
    print UI_FRAME_VERTICAL.yellow + " "
  end

  def draw_vert_frame_end
    print " " + UI_FRAME_VERTICAL.yellow
  end
  
  def draw_top_frame(width)
    print UI_FRAME_UPPER_LEFT.yellow
    (width - 2).times do
      print UI_FRAME_HORIZONTAL.yellow
    end
    print UI_FRAME_UPPER_RIGHT.yellow
    new_line
  end

  def draw_bottom_frame(width)
    print UI_FRAME_LOWER_LEFT.yellow
    (width - 2).times do
      print UI_FRAME_HORIZONTAL.yellow
    end
    print UI_FRAME_LOWER_RIGHT.yellow
    new_line
  end

  # Returns actual length of text accounting for UTF-8 and ANSI
  def get_real_size(text)
    if text.kind_of?(Array)
      text.size
    else
      text.uncolorize.size
    end
  end

  # Returns size of longest string in array
  def get_max_size_from_array(array)
    max = 0
    array.each do |s|
      s_size = get_real_size(s)
      max = s_size if s_size >= max
    end
    max + 4
  end

end

end
