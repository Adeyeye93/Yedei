defmodule SpellChecker.Spell do
  @moduledoc """
  Documentation for Spell.
  """
  require Logger
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    python_path = Path.join(:code.priv_dir(:collector), "python")
    {:ok, python} = :python.start_link([{:python_path, to_charlist(python_path)}])
    {:ok, python}
  end

  def spell_error(chunk) do
    start_link(:ok)
    GenServer.call(__MODULE__, {:spell_error, chunk})
  end

  def handle_call({:spell_error, chunk}, _from, python) do
    args = [chunk]
    result = :python.call(python, :spell, :spell_error, args)
    {:reply, result, python}
  end

  def process_file_for_txt(file_path) do
    %{total_words: total_words, total_errors: total_errors} =
      File.stream!(file_path, [], :line)
      |> Enum.reduce(%{total_words: 0, total_errors: 0}, fn line, acc ->
        words =
          String.split(line, " ", trim: true)
          |> Enum.uniq()

        task = Task.async(fn -> process_chunk(words) end)
        error_words = Task.await(task)

        %{
          total_words: acc.total_words + length(words),
          total_errors: acc.total_errors + length(error_words)
        }
      end)

    Reader.clean_up(file_path)
    calculate_error_percentage(total_words, total_errors)
  end

  defp process_chunk(chunk) do
    spell_error(chunk)
  end

  defp calculate_error_percentage(total_words, total_errors) when total_words > 0 do
    IO.puts("Calc: #{total_errors} / #{total_words}")
  end

  defp calculate_error_percentage(_, _), do: 0
end
