defmodule WorkerPool do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      :poolboy.child_spec(:worker_pool, worker_pool_config(), [])
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp worker_pool_config do
    [
      {:name, {:local, :worker_pool}},
      {:worker_module, TweetPrinter},
      {:size, 3},
      {:max_overflow, 0}
    ]
  end
end
