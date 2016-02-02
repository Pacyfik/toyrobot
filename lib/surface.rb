class Surface
  attr_accessor :current_coordinates, :size

  @@DEFAULT_SIZE = { x: 5, y: 5 }
  @@DIRECTIONS = { n: 'NORTH', s: "SOUTH", e: "EAST", w: "WEST" }

  # can take a hash with two keys/board dimensions - x (width) and y (height)
  def initialize(size = @@DEFAULT_SIZE)
    @size = size
    @current_coordinates = nil
    @board = Array.new(@size[:y]) { Array.new(@size[:x], "*") }
  end

  def set_robot(x, y, direction)
    if x && y && x < @size[:x] && y < @size[:y]
      @board[@current_coordinates[:y]][@current_coordinates[:x]] = '*' if @current_coordinates
      @board[y][x] = direction[0].upcase
      @current_coordinates = { x: x, y: y }
      return true
    elsif x.nil? || y.nil?
      puts 'No coordinates given.'
    elsif x >= @size[:x] || y >= @size[:y]
      puts 'Coordinates out of surface bounds.'
    end

    false
  end

  def current_direction
    @board[@current_coordinates[:y]][@current_coordinates[:x]]
  end

  def change_direction(direction)
    @board[@current_coordinates[:y]][@current_coordinates[:x]] = direction if @current_coordinates
  end

  def move_robot
    if @current_coordinates
      out_of_bounds = false
      new_coordinates = @current_coordinates.clone

      case @board[@current_coordinates[:y]][@current_coordinates[:x]]
      when "N"
        if (@current_coordinates[:y] + 1) < @size[:y] && (@current_coordinates[:y] + 1) >= 0
          @board[@current_coordinates[:y] + 1][@current_coordinates[:x]] = "N"
          new_coordinates[:y] += 1
        else
          out_of_bounds = true
        end
      when "S"
        if (@current_coordinates[:y] - 1) < @size[:y] && (@current_coordinates[:y] - 1) >= 0
          @board[@current_coordinates[:y] - 1][@current_coordinates[:x]] = "S"
          new_coordinates[:y] -= 1
        else
          out_of_bounds = true
        end
      when "E"
        if (@current_coordinates[:x] + 1) < @size[:x] && (@current_coordinates[:x] + 1) >= 0
          @board[@current_coordinates[:y]][@current_coordinates[:x] + 1] = "E"
          new_coordinates[:x] += 1
        else
          out_of_bounds = true
        end
      when "W"
        if (@current_coordinates[:x] - 1) < @size[:x] && (@current_coordinates[:x] - 1) >= 0
          @board[@current_coordinates[:y]][@current_coordinates[:x] - 1] = "W"
          new_coordinates[:x] -= 1
        else
          out_of_bounds = true
        end
      else
        puts "Wrong direction given."
        return false
      end

      if out_of_bounds
        puts "This move would place the robot out of board bounds."
        return false
      else
        @board[@current_coordinates[:y]][@current_coordinates[:x]] = '*'
        @current_coordinates = new_coordinates.clone
      end

      return true
    end

    false
  end

  def report
    if @current_coordinates
      puts "#{@current_coordinates[:x]},#{@current_coordinates[:y]},#{@@DIRECTIONS[@board[@current_coordinates[:y]][@current_coordinates[:x]].downcase.to_sym]}"
      draw
    else
      puts 'Robot not placed yet.'
    end
  end

  private

  def draw
    (@size[:x] + 2).times { print "-" }
    puts ""
    @board.reverse.each do |line|
      print "|"
      line.each { |spot| print spot }
      puts "|"
    end
    (@size[:x] + 2).times { print "-" }
    puts ""
  end
end
