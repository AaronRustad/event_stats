defmodule EventStats do
  import Plug.Conn
  import RGPlug
  use Plug.Router

  plug :match
  plug :dispatch

  get "/players/not_founds" do
    send_resp(conn, 200, Player.not_founds, as: :json)
  end

  get "/playlists/not_founds" do
    send_resp(conn, 200, Playlist.not_founds, as: :json)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end

IO.puts "Running EventStats with Cowboy on http://localhost:4000"
Plug.Adapters.Cowboy.http EventStats, []
