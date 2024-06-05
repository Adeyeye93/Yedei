defmodule Reader do
  @moduledoc """
  sanitize file content and process file
  """
  require Logger

  def plain_text(path),
    do: plain_text_sanitizer(path, "C:\\Users\\seyi\\Desktop\\yedei\\apps\\collector\\lib")

  defp plain_text_sanitizer(file_path, temp_path) do
    special_characters = [
      "~",
      "!",
      "@",
      "#",
      "$",
      "%",
      "^",
      "&",
      "*",
      "(",
      ")",
      "_",
      "+",
      "-",
      "=",
      "{",
      "}",
      "[",
      "]",
      "|",
      "\\",
      ":",
      ";",
      "\"",
      "'",
      "<",
      ">",
      ",",
      ".",
      "?",
      "/",
      "`",
      "⦁"
    ]

    case File.read(file_path) do
      {:ok, content} ->
        String.trim(content)
        |> String.replace(special_characters, " ")
        |> file_worker(temp_path)

      {:error, reason} ->
        IO.puts("Error reading file: #{reason}")
        nil
    end
  end

  def file_worker(content, path) do
    case File.mkdir_p!("#{path}/temp_file") do
      :ok ->
        id = UUID.uuid1() |> String.slice(0..7)

        try do
          Briefly.create!(directory: "#{path}/temp_file", prefix: "#{id}_", suffix: "temp.txt")

          File.write!("#{path}/temp_file/#{id}_temp.txt", content)

          "#{path}/temp_file/#{id}_temp.txt"
        rescue
          e in File.Error ->
            Logger.error("could not create file: #{e.reason}")
        end
    end
  end

  def clean_up(path), do: File.rm!(path)
end
