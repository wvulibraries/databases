# frozen_string_literal: true
require 'digest'

module Api
  module V1
    class BaseController < ActionController::API
      before_action :require_api_key
      before_action :force_json!

      # ---- Global error handling (problem+json style) ----
      rescue_from(ActionController::ParameterMissing) do |e|
        render_problem status: 400, code: 'missing_parameter',
                       title: 'Missing parameter',
                       detail: e.message
      end

      rescue_from(ActionController::BadRequest) do |e|
        render_problem status: 400, code: 'bad_request',
                       title: 'Bad request',
                       detail: e.message
      end

      rescue_from(ActionController::UnknownFormat) do
        render_problem status: 406, code: 'not_acceptable',
                       title: 'Not acceptable',
                       detail: 'Only application/json is supported for API endpoints.'
      end

      # Catch-all (keeps stacktraces out of clients; still in logs)
      rescue_from(StandardError) do |e|
        Rails.logger.error("[API ERROR] #{e.class}: #{e.message}\n#{e.backtrace&.first(5)&.join("\n")}")
        render_problem status: 500, code: 'internal_error',
                       title: 'Internal error',
                       detail: Rails.env.development? ? e.message : 'An internal error occurred. Try again later.'
      end

      private

      # ---- Auth: Accept Bearer <key> (preferred) or X-Api-Key ----
      def require_api_key
        provided = extract_api_key
        
        expected = ENV['DATABASES_API_KEY'].to_s

        if expected.blank?
            return render_problem status: 503, code: 'service_unavailable',
                                    title: 'Server misconfigured',
                                    detail: 'API key is not configured on the server.'
        end


        valid = expected.present? &&
                ActiveSupport::SecurityUtils.secure_compare(
                  Digest::SHA256.hexdigest(provided.to_s),
                  Digest::SHA256.hexdigest(expected)
                )
        return if valid

        render_problem status: 401, code: 'unauthorized',
                       title: 'Unauthorized',
                       detail: 'Provide a valid API key as a Bearer token or X-Api-Key header.'
      end

      def extract_api_key
        auth = request.get_header('HTTP_AUTHORIZATION').to_s
        return Regexp.last_match(1) if auth =~ /\ABearer\s+(.+)\z/i
        request.get_header('HTTP_X_API_KEY').presence
      end

      # ---- JSON only for API ----
      def force_json!
        request.format = :json
        response.set_header('Content-Type', 'application/json; charset=utf-8')
      end

      # ---- Helpers ----
      def render_ok(payload, cache_for: 30, etag_key: nil)
        # Cheap conditional GET support
        etag = Array(etag_key || payload).to_s
        if stale?(etag: etag, public: true)
          expires_in cache_for, public: true
          render json: payload
        end
      end

      # RFC 7807-ish error envelope
      def render_problem(status:, code:, title:, detail: nil, extras: nil)
        body = {
          errors: [
            {
              status: status,
              code: code,
              title: title,
              detail: detail,
              request_id: request.request_id
            }.merge(extras.is_a?(Hash) ? extras : {})
          ]
        }
        render json: body, status: status
      end
    end
  end
end
