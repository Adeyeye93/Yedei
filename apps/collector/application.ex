defmodule Collector.Application do
  use Application

  def start(start_type, start_args) do
    children = [
      {SpellChecker, []}
    ]

   opts = [strategy: :one_for_one, name: Collector.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
