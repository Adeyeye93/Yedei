defmodule SecondaryLogics.Logics do
  alias Collector
  alias SpellChecker.Spell, as: Spell

  def plain_text(path) do
    path
    |> Collector.type_determiner()
    |> Spell.process_file_for_txt()
    |> IO.puts()
  end
end
