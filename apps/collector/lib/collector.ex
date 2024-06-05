defmodule Collector do
  @moduledoc """
  Documentation for `Collector` :: Collector Major on collecting data, terming datatype, make security check and send to appropriate module .
  """
  alias Reader

  @plain_text ~w(txt)
  @code_text ~w(.c .h .cpp .hpp .java .js .ts .py .rb .php .pl .sh .bat .go .rs .swift .kt .cs .ex .exs .erl)
  @markup_types ~w(.html .htm .xml .json .yaml .yml .csv .tsv)
  @configuration_type ~w(.conf .config .ini .toml .env)
  @documentation_and_markdown_type ~w(.md .markdown .rst .adoc .tex)
  @log_file ~w(.log)
  @script_file ~w(.r .m .ps1 .lua)
  # @others ~w(.sql)


  def type_determiner(file_path) do
    MIME.from_path(file_path)
    |> MIME.extensions()
    |> Enum.fetch!(0)
    |> type_filter(file_path)
  end

  defp type_filter(type, file_path) do
    cond do
      Enum.member?(@plain_text, type) == true ->
        Reader.plain_text(file_path)

      Enum.member?(@code_text, type) == true ->
        "Found in code"

      Enum.member?(@markup_types, type) == true ->
        "Found in markup"

      Enum.member?(@configuration_type, type) == true ->
        "Found in configuration"

      Enum.member?(@documentation_and_markdown_type, type) == true ->
        "Found in documentation"

      Enum.member?(@log_file, type) == true ->
        "Found in log"

      Enum.member?(@script_file, type) == true ->
        "Found in script"

      true ->
        "Found in other #{type}"
    end
  end
end
