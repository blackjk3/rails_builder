module RailsBuilder
  class ControllersController < ApplicationController
    respond_to :json

    def index
      controllers = []
      Dir[Rails.root.join('app/controllers/*.rb').to_s].each do |filename|
        controller_name = File.basename(filename).sub(/.rb$/, '').camelize
        methods = controller_name.constantize.action_methods
        controllers << { :name => controller_name, :methods => methods }
      end

      respond_with(controllers)
    end
  end
end