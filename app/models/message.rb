class Message < ApplicationRecord
  belongs_to :chat

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name    'messages'
  messages_es_settings = {
    index: {
      analysis: {
        filter: {
          ngram_filter: {
            type: "ngram",
            min_gram: 1,
            max_gram: 20
          }
        },
        analyzer:{
          ngram: {
            type: "custom",
            tokenizer: "standard",
            filter: ["lowercase", "ngram_filter"]
          }
        }
      }
    }
  }
  settings messages_es_settings do
    mapping dynamic: 'false' do
      indexes :body, type: 'string', analyzer: 'ngram'
    end
  end
end
