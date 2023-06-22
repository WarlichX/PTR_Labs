defmodule W2 do
  use Application

  def start(_type, _args) do
    children = [
      {Reader, "http://localhost:8080/stream"},
      LoadBalancer,
      WorkerPool,
      Aggregator,
      Batcher,
      Database
    ]

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
