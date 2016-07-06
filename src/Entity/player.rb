require_relative 'entity.rb'
require_relative '../Map/map_zdrasvootyay.rb'
require_relative '../command.rb'
require_relative '../util.rb'

class Player < Entity

  def initialize(name, max_hp = 100, hp = 100)
    super
    @max_hp = max_hp
    @hp = hp
    @map = Zdrasvootyay.new
    @location = Couple.new(1,5)
    update_player_map
  end

  attr_accessor :map, :location

  def move(direction)
    case direction
    when "w"
      if @map.tiles[@location.first][@location.second - 1].passable
        @location.second -= 1
        update_player_map
        prompt(self)
      else
        print "You can't go that way!\n\n"
        #print possible directions
      end
    when "e"
      if @map.tiles[@location.first][@location.second + 1].passable
        @location.second += 1
        update_player_map
        prompt(self)
      else
        print "You can't go that way!\n\n"
        #print possible directions
      end
    when "n"
      if @map.tiles[@location.first - 1][@location.second].passable
        @location.first -= 1
        update_player_map
        prompt(self)
      else
        print "You can't go that way!\n\n"
        #print possible directions
      end
    when "s"
      if @map.tiles[@location.first + 1][@location.second].passable
        @location.first += 1
        update_player_map
        prompt(self)
      else
        print "You can't go that way!\n\n"
        #print possible directions
      end
    else
      puts "That ain't no D-recshun"
    end

  end

  #call after each move
  def update_player_map
    @map.tiles[@location.first][location.second].seen = true
    #corners
    @map.tiles[@location.first + 1][@location.second - 1].seen = true
    @map.tiles[@location.first - 1][@location.second - 1].seen = true
    @map.tiles[@location.first + 1][@location.second + 1].seen = true
    @map.tiles[@location.first - 1][@location.second + 1].seen = true
    #cardinal directions
    @map.tiles[@location.first][@location.second + 1].seen = true
    @map.tiles[@location.first][@location.second - 1].seen = true
    @map.tiles[@location.first - 1][@location.second].seen = true
    @map.tiles[@location.first + 1][@location.second].seen = true
  end

  def print_player_map

    puts "\nYou're in " + @map.name + "!\n\n"
    row_count = 0
    @map.tiles.each do |sub|
      #centers each row under the "welcome" sign
      for i in 1..(@map.name.length/2)
        print " "
      end
      col_count = 0
      sub.each do |tile|
        if tile.seen
          if tile.passable
            if row_count == @location.first && col_count == @location.second
              print "¶"
            else
              print "•"
            end
          else
            print "#"
          end
        else
          print " "
        end
        col_count += 1
      end
      row_count += 1
      puts ""
    end
    puts "\n• - passable space" +
         "\n# - impassable space" +
         "\n¶ - your location"
  end
end
