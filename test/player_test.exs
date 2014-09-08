defmodule PlayerTest do
  use ExUnit.Case, async: true

  defmodule Response do
    def body do
      ~s({"took":925,"timed_out":false,"_shards":{"total":12,"successful":12,"failed":0},"hits":{"total":0,"max_score":1.0,"hits":[]}})
    end
  end

  defmodule TestClient do
    def post(_, _) do
      Response
    end
  end

  setup do
    Application.put_env(:common_http, :http_client, TestClient)
    :ok
  end

  test "not_founds" do
    results = Player.not_founds
    assert Enum.count(results[:hits]) == 0
  end
end
