require 'spec_helper'

describe Surface do
  before(:each) do
    @surface = Surface.new
  end

  it 'initializes with default dimensions' do
    expect(@surface.size).to eq({ x: 5, y: 5 })
  end

  it 'initializes with custom dimensions when they are given' do
    surface = Surface.new({ x: 10, y: 10 })
    expect(surface.size).to eq({ x: 10, y: 10 })
  end

  it 'has no coordinates set' do
    expect(@surface.current_coordinates).to eq(nil)
  end

  context '#set_robot' do
    it '#set_robot returns true when correct arguments are given' do
      expect(@surface.set_robot(1, 1, 'north')).to eq(true)
    end

    it '#set_robot returns false when invalid arguments are given' do
      expect(@surface.set_robot(nil, nil, 'north')).to eq(false)
    end

    it '#set_robot returns false when coordinates are outside the surface size' do
      expect(@surface.set_robot(10, 10, 'north')).to eq(false)
    end
  end

  context 'when robot is set' do
    before(:each) do
      @surface.set_robot(1, 1, 'north')
    end

    it 'has coordinates when correct arguments are given' do
      expect(@surface.current_coordinates).to eq({ x: 1, y: 1 })
    end

    it 'no coordinates set when invalid arguments are given' do
      surface = Surface.new
      surface.set_robot(nil, nil, 'north')
      expect(surface.current_coordinates).to eq(nil)
    end

    it 'no coordinates set when coordinates are outside the surface size' do
      surface = Surface.new
      surface.set_robot(10, 10, 'north')
      expect(surface.current_coordinates).to eq(nil)
    end

    it 'changes direction on the board' do
      @surface.change_direction('s')
      expect(@surface.current_direction).to eq('s')
    end

    it '#move_robot returns true when move is permitted' do
      expect(@surface.move_robot).to eq(true)
    end

    it '#move_robot returns false when move is not permitted' do
      surface = Surface.new
      surface.set_robot(0, 0, 'south')
      expect(surface.move_robot).to eq(false)
    end

    it 'moves the robot on the board' do
      @surface.move_robot
      expect(@surface.current_coordinates).to eq({ x: 1, y: 2 })
    end

    it 'draws the board when report is called' do
      expect(@surface).to receive(:draw)
      @surface.report
    end
  end
end
