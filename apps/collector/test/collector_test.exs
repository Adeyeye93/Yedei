defmodule CollectorTest do
  use ExUnit.Case
  doctest Collector

  test "greets the world" do
    assert SecondaryLogics.Logics.plain_text(
             "C:\\Users\\seyi\\Desktop\\yedei\\apps\\collector\\lib\\text.txt"
           )
  end
end
