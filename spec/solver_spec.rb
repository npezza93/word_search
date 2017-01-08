# frozen_string_literal: true
require "spec_helper"

describe WordSearch::Solver do
  let(:plane_file) do
    tempfile = Tempfile.new
    tempfile.write "xx\nxx"
    tempfile.rewind
    tempfile
  end

  let(:script) do
    tempfile = Tempfile.new(["test", ".rb"])
    tempfile.write "puts 'hi'"
    tempfile.rewind
    tempfile
  end

  it "makes a solver" do
    solver = WordSearch::Solver.new(
      Tempfile.new, "spec/support/words.csv", plane_file
    )
    expect(solver).to be_a WordSearch::Solver
  end

  it "executes a script" do
    solver = WordSearch::Solver.new(
      script, "spec/support/words.csv", plane_file
    )
    expect(solver.execute)
  end
end
