module Api
    module V1
      class HealthController < ApplicationController
        skip_before_action :authenticate_request
  
        def show
          db_ok = database_ok?
  
          payload = {
            status: db_ok ? 'ok' : 'degraded',
            time:   Time.current.iso8601,
            checks: {
              db: db_ok
            }
          }
  
          render json: payload, status: db_ok ? :ok : :service_unavailable
        end
  
        private
  
        def database_ok?
          ActiveRecord::Base.connection.execute('SELECT 1')
          true
        rescue StandardError
          false
        end
      end
    end
  end
  