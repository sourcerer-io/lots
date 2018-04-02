#!/usr/bin/env ruby
#
# Legend of the Sourcerer
# Written by Robert W. Oliver II <robert@cidergrove.com>
# Copyright (C) 2018 Sourcerer, All Rights Reserved.
# Licensed under GPLv3.
#
# Story Class
#

module LOTS

STORY_INTRO = [
"Your journey to discover your true potential has been arduous, but a glimmer of hope shines in the darkness.",
"A vivid dream stirrs you from your sleep. You are instructed to visit the " + "Sourcerer".light_white + ", the Oracle of the Path.",
"You feel certain he will provide the insight you need. Inspired, you carry on.",
"",
"At the end of the day's travel, you set up camp and find an old " + "map".light_white + " at the base of a tree.",
"You gaze at the ancient parchment, studying the path ahead."
]

STORY_AREA_TREE = [
  "You see a magnificent tree standing tall above you."
]

STORY_AREA_WATER = [
  "You stand on the banks of a crystal-clear lake."
]

STORY_AREA_MOUNTAIN = [
  "A majestic snow-topped mountain range graces the horizon."
]

STORY_AREA_ENEMY = [
  "You encounter an enemy!"
]

STORY_PLAYER_DEAD = [
  "You have died.",
  "",
  "You failed to reach the Sourcerer. Please try again.",
]

class Story

  def intro
    return STORY_INTRO
  end

  def area_tree
    return STORY_AREA_TREE
  end
	
  def area_water
    return STORY_AREA_WATER
  end
	
  def area_mountain
    return STORY_AREA_MOUNTAIN
  end

  def area_enemy
    return STORY_AREA_ENEMY
  end

  def player_dead
    return STORY_PLAYER_DEAD
  end
	
end

end
