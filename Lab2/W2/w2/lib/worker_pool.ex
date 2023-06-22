defmodule WorkerPool do
  use DynamicSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_worker do
    spec = {Printer, []}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
