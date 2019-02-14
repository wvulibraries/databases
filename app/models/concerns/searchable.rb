# Searchable extends any model to be setup in an elasticsearch gem
# 
# @author David J. Davis
# @concern
# @since 0.0.1
module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    # include Elasticsearch::Model::Callbacks
    index_name [base_class.to_s.pluralize.underscore, Rails.env].join('_')

    # set number of shards
    settings number_of_shards: 1

    # create
    after_commit on: [:create] do
      __elasticsearch__.index_document
    end

    # update
    after_commit on: [:update] do
      __elasticsearch__.update_document
    end

    # delete
    after_commit on: [:destroy] do
      __elasticsearch__.delete_document
    end

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