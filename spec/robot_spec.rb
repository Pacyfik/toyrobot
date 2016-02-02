require 'spec_helper'

describe Robot do
  before(:each) do
    surface = double("Surface")
    allow(surface).to receive(:set_robot).with(1, 1, 'n').and_return(true)
    allow(surface).to receive(:move_robot).and_return(true)
    allow(surface).to receive(:current_coordinates).and_return({ x: 1, y: 2 })
    allow(surface).to receive(:change_direction).and_return(true)

    @robot = Robot.new(OpenStruct.new(surface: surface))
  end

  it 'initializes properly' do
    expect(@robot.class).to eq(Robot)
  end

  context 'after initialization' do
    it "initially doesn't have a position set" do
      expect(@robot.position).to eq(nil)
    end

    it "initially doesn't have a direction set" do
      expect(@robot.direction).to eq(nil)
    end
  end

  context 'after #place is sent' do
    before(:each) do
      @robot.place(1, 1, 'north')
    end

    it 'has a position' do
      expect(@robot.position).to eq({ x: 1, y: 1 })
    end

    it 'has a direction' do
      expect(@robot.direction).to eq('n')
    end

    it 'changes position after #move_forward is sent' do
      @robot.move_forward
      expect(@robot.position).to eq({ x: 1, y: 2 })
    end

    it 'changes direction after #turn_left is sent' do
      @robot.turn_left
      expect(@robot.direction).to eq('w')
    end

    it 'changes direction after #turn_right is sent' do
      @robot.turn_right
      expect(@robot.direction).to eq('e')
    end
  end
end
