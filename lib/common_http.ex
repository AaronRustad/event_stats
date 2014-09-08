defmodule CommonHttp do
  alias Timex.Date; alias Timex.DateFormat

  def query(path, body) do
    url = process_url(path)

    http_client.post(url, body).body
    |> Poison.decode!
    |> process_results
  end

  def process_results(%{"status" => code}) when code in 400..499 do
    "CLIENT ERROR"
  end

  def process_results(%{"status" => code}) when code in 500..599 do
    "SERVER ERROR"
  end

  def process_results(results) do
    data = Enum.map(results["hits"]["hits"], fn(hit) -> hit["fields"] end)
    %{hits: data}
  end

  def current_index do
    "logstash-" <> DateFormat.format!(Date.now, "%Y.%m.%d", :strftime)
  end

  defp process_url(path) do
    es_url = Application.get_env(:event_stats, :elasticsearch_url)
    "#{es_url}/#{path}"
  end

  defp http_client do
    Application.get_env(:common_http, :http_client)
  end
end

