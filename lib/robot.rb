class Robot
  attr_reader :position, :direction

  @@DIRECTIONS = ['n', 'e', 's', 'w']

  def initialize(game)
    @game = game
    @position = nil
    @direction = nil
  end

  def place(x, y, direction)
    if @game.surface.set_robot(x.to_i, y.to_i, direction[0].downcase)
      @position = { x: x.to_i, y: y.to_i }
      @direction = direction[0].downcase
      puts "Robot placed."
    end
  end

  def move_forward
    check_placement {
      if @game.surface.move_robot
        @position = @game.surface.current_coordinates.clone
        puts "Robot moved."
      end
    }
  end

  def turn_left
    check_placement {
      @direction = @@DIRECTIONS.rotate(@@DIRECTIONS.index(@direction)).last
      @game.surface.change_direction(@direction.upcase)
      puts "Turned left."
    }
  end

  def turn_right
    check_placement {
      @direction = @@DIRECTIONS.rotate(@@DIRECTIONS.index(@direction))[1]
      @game.surface.change_direction(@direction.upcase)
      puts "Turned right."
    }
  end

  private

  def check_placement
    @position ? yield : puts('Robot not placed yet.')
  end
end
