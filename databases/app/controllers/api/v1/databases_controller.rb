# frozen_string_literal: true
module Api
  module V1
    class DatabasesController < BaseController
      def search
        # Ensure the query parameter is present
        if params[:query].blank? && params[:q].blank?
          return render_problem(status: 400, code: 'missing_query', title: 'Missing query', detail: 'Provide ?query=...')
        end

        q = sanitize_query!(params.fetch(:query, params[:q]))

        # Fetch the number of results to return (default: 3, max: 10)
        per_page = params[:per_page].to_i
        per_page = 3 if per_page <= 0
        per_page = 10 if per_page > 10

        begin
          es = Database.search(q).per(per_page)
        rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
          return render_problem status: 422, code: 'invalid_query',
                                title: 'Invalid query syntax',
                                detail: short_es_message(e)
        rescue Elasticsearch::Transport::Transport::Errors::ServiceUnavailable,
               Elasticsearch::Transport::Transport::Errors::GatewayTimeout,
               Faraday::TimeoutError => e
          return render_problem status: 504, code: 'upstream_timeout',
                                title: 'Search backend timeout',
                                detail: 'The search service timed out. Try again.'
        rescue Elasticsearch::Transport::Transport::Error => e
          return render_problem status: 502, code: 'upstream_error',
                                title: 'Search backend error',
                                detail: short_es_message(e)
        end

        records = es.records

        results = records.map do |r|
          {
            id: r.id,
            title: r.name,
            vendor: r.vendor_name,
            url: "https://databases.lib.wvu.edu/connect/#{r.url_uuid}",
            snippet: r.description
          }
        end

        payload = {
          query: q,
          per_page: per_page,
          count: results.size,
          results: results
        }

        render_ok payload, cache_for: 30, etag_key: [q, per_page, results.map { |h| h[:id] }]
      end

      private

      def sanitize_query!(raw)
        raw = raw.to_s.strip
        clean = raw.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
        Sanitize.fragment(clean)
      end

      def short_es_message(e)
        msg = e.message.to_s
        msg.length > 200 ? msg[0, 200] + '…' : msg
      end
    end
  end
end
