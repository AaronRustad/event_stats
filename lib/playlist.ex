defmodule Playlist do
  import CommonHttp

  @not_found_query Poison.encode!(%{
      :fields => ["@fields.params.uuid", "@fields.env.referer"],
      :filter =>
        %{
          :and => [
            %{"term"  => %{"@fields.object"      => "playlistscontroller"}},
            %{"term"  => %{"@fields.http.status" => "404"}},
            %{"range" => %{"@timestamp"          => %{"gte" => "now-15m"}}}
          ]
        }
     })

  def not_founds do
    not_founds([index: current_index])
  end

  def not_founds([index: index]) do
    query("#{index}/_search", @not_found_query)
  end
end

