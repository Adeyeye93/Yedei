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
    GenServer.call(__MODULE__, {:spell_error, chunk})
  end

  def handle_call({:spell_error, chunk}, _from, python) do
    args = [chunk]
    result = :python.call(python, :spell, :spell_error, args)
    {:reply, result, python}
  end

  def process_file_for_txt(file_path) do
    File.stream!(file_path, [], :line)
    |> Stream.map(&Task.async(fn -> process_chunk(&1) end))
    |> Enum.map(&Task.await(&1))
    |> List.flatten()
    |> Enum.uniq()
    |> Logger.info()
  end

  defp process_chunk(chunk) do
    spell_error(chunk)
  end
end
