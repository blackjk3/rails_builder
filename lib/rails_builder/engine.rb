module RailsBuilder
  class Engine < ::Rails::Engine
    isolate_namespace RailsBuilder
    engine_name 'rails_builder'
    # initializer 'asset_pipeline' do |app|
    #   app.config.assets.precompile += ['rails_builder.js', 'rails_builder.css']
    # end
  end
end
