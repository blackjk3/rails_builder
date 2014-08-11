require 'active_record'
require 'rails/generators'
require 'rails/generators/active_record'
require 'rails/generators/active_record/model/model_generator'

module RailsBuilder
  class MigrationsController < ApplicationController

    respond_to :json

    def create
      # Todo: Generate a migration
    end

    def migrate
      begin
        ActiveRecord::Migrator.forward(ActiveRecord::Migrator.migrations_paths)
        success_response
      rescue Exception => e
        rescue_response(e)
      end
    end

    def rollback
      begin
        ActiveRecord::Migrator.rollback(ActiveRecord::Migrator.migrations_paths)
        success_response
      rescue Exception => e
        rescue_response(e)
      end
    end

    def up
      run_migration(:up, params[:version].to_i)
    end

    def down
      run_migration(:down, params[:version].to_i)
    end

    def reload
      version = params[:version].to_i
      unless version.nil?
        begin
          ActiveRecord::Migrator.run(:down, ActiveRecord::Migrator.migrations_paths, version)
          ActiveRecord::Migrator.run(:up, ActiveRecord::Migrator.migrations_paths, version)
          success_response
        rescue Exception => e
          rescue_response(e)
        end
      else
        response = {}
        response[:error] = 'No version added.'
        respond_with(response, location: nil)
      end
    end

    def index
      unless ActiveRecord::Base.connection.table_exists?(ActiveRecord::Migrator.schema_migrations_table_name)
        response = {}
        response[:error] = 'Schema migrations table does not exist yet.'
        respond_with(response, location: nil)
      else
        # Migrations exist let's iterate over the status...
        db_list = ActiveRecord::Base.connection.select_values("SELECT version FROM #{ActiveRecord::Migrator.schema_migrations_table_name}")
        db_list.map! { |version| "%.3d" % version }
        file_list = []
        final_list = []
        final_object = {}
        up_count = 0
        down_count = 0

        ActiveRecord::Migrator.migrations_paths.each do |path|
          Dir.foreach(path) do |file|
            # match "20091231235959_some_name.rb" and "001_some_name.rb" pattern
            if match_data = /^(\d{3,})_(.+)\.rb$/.match(file)
              status = db_list.delete(match_data[1]) ? 'up' : 'down'
              file_list << [status, match_data[1], match_data[2].humanize]

              if status == 'up'
                up_count = up_count + 1
              else
                down_count = down_count + 1
              end
            end
          end
        end
        db_list.map! do |version|
          ['up', version, '********** NO FILE **********']
        end

        (db_list + file_list).sort_by {|migration| migration[1]}.each do |migration|
          final_list << migration
        end

        final_object[:statistics] = {
          version: ActiveRecord::Migrator.current_version,
          up: up_count,
          down: down_count
        }

        final_object[:migrations] = final_list

        respond_with(final_object)
      end
    end

    private

      def success_response
        response = {}
        response[:success] = true
        respond_with(response, location: nil)
      end

      def rescue_response(e)
        message = "#{e.class.name}: #{e.message}"
        response = {}
        response[:error] = message
        respond_with(response, location: nil)
      end

      def run_migration(direction, version)
        unless version.nil?
          begin
            ActiveRecord::Migrator.run(direction, ActiveRecord::Migrator.migrations_paths, version)
            success_response
          rescue Exception => e
            rescue_response(e)
          end
        else
          response = {}
          response[:error] = 'No version added.'
          respond_with(response, location: nil)
        end
      end
  end
end