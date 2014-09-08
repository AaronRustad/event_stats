defmodule AppConfig do
  def start_link do
    Agent.start_link(fn -> HashDict.new end, name: __MODULE__)
  end

  def add_conf(name, item) do
    Agent.update(__MODULE__, fn dict -> Dict.put(dict, name, item) end)
  end

  def get_conf(name) do
    Agent.get(__MODULE__, fn dict -> Dict.get(dict, name) end)
  end
end

