defmodule Subtitlex.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, [name: __MODULE__])
  end

  def start_child(episode_name) when episode_name |> is_binary do
    Supervisor.start_child(__MODULE__, [episode_name])
  end

  def init(:ok) do
    children = [worker(Subtitlex.Fetcher, [])]
    supervise(children, strategy: :simple_one_for_one)
  end
end
