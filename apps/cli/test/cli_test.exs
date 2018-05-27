defmodule CliTest do
  use ExUnit.Case
  doctest Cli

  test "greets the world" do
    assert Cli.hello() == :world
  end
end
