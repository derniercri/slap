defmodule RunnerTest do
  use ExUnit.Case
  doctest Runner

  test "greets the world" do
    assert Runner.hello() == :world
  end
end
