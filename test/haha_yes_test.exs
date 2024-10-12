defmodule HahaYesTest do
  use ExUnit.Case
  doctest HahaYes

  test "greets the world" do
    assert HahaYes.hello() == :world
  end
end
