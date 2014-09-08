defmodule CommonHttp do
  use HTTPotion.Base
  alias Timex.Date; alias Timex.DateFormat

  def process_url(url) do
    es_url = Application.get_env(:event_stats, :elasticsearch_url)
    "#{es_url}/#{url}"
  end

  def query(path, body) do
    post(path, body).body
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
end

