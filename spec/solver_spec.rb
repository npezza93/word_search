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

  it "executes a script" do
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
end
