require 'spec_helper'

describe WordSearch::Plane do
  it 'makes a plane' do
    plane = WordSearch::Plane.new(5,5)
    expect(plane).to be_a WordSearch::Plane
  end
end
