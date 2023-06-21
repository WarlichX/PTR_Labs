defmodule MySupervisor do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: :my_supervisor)
  end

  def init(:ok) do
    children = [
      {Worker, :ok}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
