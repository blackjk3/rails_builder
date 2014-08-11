module RailsBuilder 
  class ModelsController < ApplicationController
    respond_to :json

    def index
      models = []
      Dir[Rails.root.join('app/models/*.rb').to_s].each do |filename|
        model_name = File.basename(filename).sub(/.rb$/, '').camelize
        model = model_name.constantize
        associations = model.reflections

        models << {
          :name => model_name,
          :primary_key => model.primary_key,
          :table_name => model.table_name,
          :attributes => model.accessible_attributes,
          :associations => associations.map { |i| { type: i[1].macro, name: i[1].name, foreign_key: i[1].foreign_key } }
        }
      end

      respond_with(models)
    end
  end
end