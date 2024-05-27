defmodule SpellChecker.Spell do
  @moduledoc """
  Documentation for ElixirPythonQrcode.
  """
  require Logger
  alias SpellChecker.SpellPythonHelper

  defp default_instance() do
    # Load all modules in our priv/python directory
    path =
      [:code.priv_dir(:collector), "python"]
      |> Path.join()

    # |> Logger.info()

    SpellPythonHelper.python_instance(to_charlist(path))
  end

  # wrapper function to call python functions using
  # default python instance
  defp call_python(module, function, args \\ []) do
    default_instance()
    |> SpellPythonHelper.call_python(module, function, args)
  end

  def greetings() do
    call_python(:spell, :greetings, [])
  end
end
