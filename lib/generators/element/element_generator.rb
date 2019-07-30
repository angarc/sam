class ElementGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('templates', __dir__)
  argument :model, type: :string

  def edit_routes
    route("\tresources :#{model.pluralize.underscore} do
      member do
        post :toggle_status
        post :increment_pos
        post :decrement_pos
      end
    end")
  end

  def generate_model
    generate_element
  end

  def self.next_migration_number(dir)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  private
  def route(routing_code)
    log 'route', routing_code
    sentinel = 'namespace :control_room do'
  
    in_root do
      gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
        "#{match}\n  #{routing_code}\n"
      end
    end
  end

  def generate_element
    migration_template "element_migration.rb", "db/migrate/create_#{model.pluralize.underscore}.rb"
    template 'element_model_controller_template.template', "app/controllers/control_room/#{model.pluralize.underscore}_controller.rb"
    template 'element_model_template.template', "app/models/#{model.singularize.underscore}.rb"
    template 'element_model_view_template.template', "app/views/control_room/#{model.pluralize.underscore}/_content.html.erb"
  end
end
