class Gon
  module Helpers

    def self.included base
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods

      def include_gon(options = {})
        if variables_for_request_present?
          Gon::Base.render_data(options)
        elsif Gon.global.all_variables.present?
          Gon.clear
          Gon::Base.render_data(options)
        elsif options[:init].present?
          Gon.clear if Gon.all_variables.present?
          Gon::Base.render_data(options)
        else
          ''
        end
      end

      private

      def variables_for_request_present?
        current_gon.gon.present?
      end

      def current_gon
        Thread.current['gon']
      end

    end
  end

  module GonHelpers

    def self.included base
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods

      def gon
        if wrong_gon_request?
          gon_request = Request.new(env)
          gon_request.uuid = request.uuid
          Thread.current['gon'] = gon_request
        end
        Gon
      end

      private

      def wrong_gon_request?
        current_gon.blank? || current_gon.uuid != request.uuid
      end

      def current_gon
        Thread.current['gon']
      end

    end
  end
end

ActionView::Base.send :include, Gon::Helpers
ActionController::Base.send :include, Gon::GonHelpers
