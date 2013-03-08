# RailsAdmin config file. Generated on December 31, 2012 16:53
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Eretheal', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['AssignedSkill', 'Attribute', 'Belonging', 'Candy', 'Character', 'Enemy', 'Equip', 'Field', 'Item', 'ItemType', 'Job', 'Position', 'Skill', 'StatusAdjustment', 'StatusCoefficient', 'SystemMessage', 'User']

  # Include specific models (exclude the others):
  # config.included_models = ['AssignedSkill', 'Attribute', 'Belonging', 'Candy', 'Character', 'Enemy', 'Equip', 'Field', 'Item', 'ItemType', 'Job', 'Position', 'Skill', 'StatusAdjustment', 'StatusCoefficient', 'SystemMessage', 'User']

  # Label methods for model instances:
  config.label_methods << :key # Default is [:name, :title]
end
