# frozen_string_literal: true

require "spec_helper"

describe WordSearch::Solver do
  let(:plane_file) do
    tempfile = Tempfile.new
    tempfile.write "hi\nxx"
    tempfile.rewind
    tempfile
  end

  it "benchmarks a solution" do
    WordSearch::Solver.any_instance.stubs(
      :users_solution
    ).returns({ "hi" => { 0 => [0, 1], 1 => [1, 1] } })

    solver = WordSearch::Solver.new(
      Tempfile.new, "spec/support/solver_words.csv", plane_file
    )
    expect(solver.perform).to be_a Benchmark::Tms
  end

  it "returns an invalid message if answer is incorrect" do
    WordSearch::Solver.any_instance.stubs(:users_solution).returns({})
    WordSearch::Solver.any_instance.stubs(:solved?).returns(false)

    solver = WordSearch::Solver.new(
      Tempfile.new, "spec/support/solver_words.csv", plane_file
    )
    expect(solver.perform).to be "Word Search incorrectly solved"
  end
end
