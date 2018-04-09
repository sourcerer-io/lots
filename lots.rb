#!/usr/bin/env ruby
#
# Legend of the Sourcerer
# Written by Robert W. Oliver II <robert@cidergrove.com>
# Copyright (C) 2018 Sourcerer, All Rights Reserved.
# Licensed under GPLv3.

LOTS_VERSION = "1.00"

begin
  require 'colorize'
rescue LoadError
  puts
  puts "Legend of the Sourcerer requires the 'colorize' gem to run."
  puts
  puts "Installation Instructions"
  puts "-------------------------"
  puts 
  puts "Debian/Ubuntu Linux:"
  puts "  sudo apt install ruby-colorize"
  puts
  puts "Other Linux Distros:"
  puts "  gem install colorize"
  puts
  puts "Windows:"
  puts "  gem install colorize"
  puts
  puts "macOS:"
  puts "  gem install colorize"
  puts
  puts
  exit
end

# Require libraries
load "lib/ui.rb"
load "lib/world.rb"
load "lib/character.rb"
load "lib/story.rb"
load "lib/enemy.rb"

# Start
load "lib/main.rb"
