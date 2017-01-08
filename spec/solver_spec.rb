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
      :master_solutions
    ).returns({ "hi" => { 0 => [1, 1], 1 => [2, 2] } })
    WordSearch::Solver.any_instance.stubs(
      :execute_users_solution
    ).returns({ "hi" => { 0 => [1, 1], 1 => [2, 2] } })

    solver = WordSearch::Solver.new(
      Tempfile.new, "spec/support/words.csv", plane_file
    )
    expect(solver.perform).to be_a Benchmark::Tms
  end

  it "returns an invalid message if answer is incorrect" do
    WordSearch::Solver.any_instance.stubs(
      :master_solutions
    ).returns({ "hi" => { 0 => [1, 1], 1 => [2, 2] } })
    WordSearch::Solver.any_instance.stubs(
      :execute_users_solution
    ).returns({})

    solver = WordSearch::Solver.new(
      Tempfile.new, "spec/support/words.csv", plane_file
    )

    expect(solver.perform).to be "Word Search incorrectly solved"
  end

  it "generates solution if solution file not found" do
    solver = WordSearch::Solver.new(
      Tempfile.new, "spec/support/solver_words.csv", plane_file
    )

    expect(solver.master_solutions).to eq(
      { "hi" => { 0 => [0, 1], 1 => [1, 1] } }
    )
  end
end
