Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: "http://#{ENV['ES_HOST']}:9200",
)
# p "http://#{ENV['ES_USER']}:#{ENV['ES_PASSWORD']}@#{ENV['ES_HOST']}:9200"