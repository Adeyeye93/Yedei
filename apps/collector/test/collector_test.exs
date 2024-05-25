defmodule CollectorTest do
  use ExUnit.Case
  doctest Collector

  test "greets the world" do
    assert Collector.type_filter(".txt", "/text.txt")
  end
end
