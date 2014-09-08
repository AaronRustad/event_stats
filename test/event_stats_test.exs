defmodule EventStatsTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts EventStats.init([])

  test "returns world" do
    conn = conn(:get, "/hello")
    conn = EventStats.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "world"
  end

  test "returns oops" do
    conn = conn(:get, "/xxxx")
    conn = EventStats.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "oops"
  end
end
