defmodule QuoteScraper do
  def main do
    scrape()
  end

  def scrape do
    url = "https://quotes.toscrape.com/"
    {:ok, response} = HTTPoison.get(url)
    {:ok, document} = Floki.parse_document(response.body)
    quotes = parse_quotes(document)
    save_quotes(quotes)
  end

  def parse_quotes(document) do
    document
    |> Floki.find(".quote")
    |> Enum.map(&parse_quote/1)
  end

  def parse_quote(quote_html) do
    text = quote_html |> Floki.find(".text") |> Floki.text()
    author = quote_html |> Floki.find(".author") |> Floki.text()
    tags = quote_html |> Floki.find(".tag") |> Floki.text()
    %{
      "text" => text,
      "author" => author,
      "tags" => tags
    }
  end

  def save_quotes(quotes) do
    File.write!("quotes.json", Jason.encode!(quotes))
  end
end
