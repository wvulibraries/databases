# Searchable extends any model to be setup in an elasticsearch gem
# 
# @author David J. Davis
# @concern
# @since 0.0.1
module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Indexing

    # include Elasticsearch::Model::Callbacks
    index_name [base_class.to_s.pluralize.underscore, Rails.env].join('_')

    # set number of shards
    settings number_of_shards: 1

    # create / update
    after_commit lambda { __elasticsearch__.index_document  },  on: [:create, :update]

    # delete
    after_commit lambda { __elasticsearch__.delete_document },  on: :destroy

    # create a core mapping
    mapping do
      # ...
    end

    # create a core search query 
    def self.search(query)
      # ...
    end
  end
end