defmodule CollectorTest do
  use ExUnit.Case
  doctest Collector

  test "greets the world" do
    assert SpellChecker.Spell.process_file_for_txt(
             "C:\\Users\\seyi\\Desktop\\yedei\\apps\\collector\\lib\\temp_file\\0b235450_temp.txt"
           )
  end
end
