defmodule RGPlug do
  import Plug.Conn

  def send_resp(conn, status, body, [as: :json]) do
    send_resp(conn, status, Poison.encode!(body))
  end
end

