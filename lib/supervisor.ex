defmodule CowboyElixirExample.Supervisor do
  use Supervisor

  def start_link(_) do
    {:ok, sup} = Supervisor.start_link(__MODULE__, [], name: :supervisor)   
  end

  def init(_) do
    processes = []
    {:ok, {{:one_for_one, 10, 10}, processes}}
  end

end

