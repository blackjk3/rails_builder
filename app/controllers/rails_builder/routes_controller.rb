module RailsBuilder
  class RoutesController < ApplicationController
    respond_to :json

    def index
      all_routes = Rails.application.routes.routes
      routes_array = []

      routes = all_routes.collect do |route|
        if !route.requirements.empty?
          reqs = route.requirements
          verb = route.verb.source.gsub(/[$^]/, '')
          spec = route.path.spec.to_s.gsub("(.:format)", '')
          routes_array << { :name => route.name, :verb => verb, :path => spec, :action => reqs[:action], :controller => reqs[:controller] }
        end
      end

      respond_with(routes_array)
    end

  end
end
