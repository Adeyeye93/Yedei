defmodule CollectorTest do
  use ExUnit.Case
  doctest Collector

  test "greets the world" do
    assert SpellChecker.Spell.greetings()
  end
end
