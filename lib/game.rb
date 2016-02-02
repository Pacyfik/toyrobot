class Game
  attr_reader :robot, :surface

  def initialize
    @robot = Robot.new(self)
    @surface = Surface.new

    puts "Hi. Type in your commands. Remember to place your robot first.\nAvailable commands: 'PLACE X,Y,F', 'MOVE', 'LEFT', 'RIGHT', 'REPORT'.\nX and Y should be digits ranging from 0 to 4.\nF should be one of 4 directions: NORTH, SOUTH, EAST or WEST.\nPlease separate each command with a space, e.g. 'PLACE 0,0,NORTH MOVE REPORT'.\nTo exit the program type 'EXIT'.\n\n"
    get_params
  end

  private

  def get_params
    print "Enter commands: " unless ARGV[0]
    parse_params(ARGV[0] || gets.chomp)
  end

  def parse_params(params)
    params = params.split(' ').map { |a| a.downcase }
    ARGV.clear if ARGV[0]

    if params == ['exit']
      exit_game
    elsif @robot.position.nil? && !params.include?('place')
      puts 'Robot not placed yet and no PLACE command found. Try again.'
      get_params
    elsif @robot.position.nil? && params.include?('place')
      execute_params(params[params.index('place')..-1])
    else
      execute_params(params)
    end
  end

  def execute_params(params)
    params.each_with_index do |param, index|
      if param == 'exit'
        exit_game
      elsif param == 'place'
        place(params[index + 1]) if params[index + 1] && params[index + 1] =~ /^\d+,\d+,(north|south|east|west)$/i
      elsif ['move', 'left', 'right', 'report'].include? param
        self.send param.to_sym
      end
    end
    get_params
  end

  def place(coordinates)
    print 'PLACE... '
    @robot.place(*coordinates.split(','))
  end

  def move
    print 'MOVE... '
    @robot.move_forward
  end

  def left
    print 'LEFT... '
    @robot.turn_left
  end

  def right
    print 'RIGHT... '
    @robot.turn_right
  end

  def report
    print 'REPORT... '
    @surface.report
  end

  def exit_game
    puts 'Bye!'
    exit
  end
end
