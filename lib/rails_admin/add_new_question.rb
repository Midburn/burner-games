module RailsAdmin
  module Config
    module Actions
      class AddNewQuestion < RailsAdmin::Config::Actions::Base

        # This ensures the action only shows up for Questions
        register_instance_option :visible? do
          # authorized? && bindings[:object].class == Question
          true
        end

        register_instance_option :link_icon do
          'icon-plus'
        end

        # You may or may not want pjax for your action
        register_instance_option :pjax? do
          false
        end

        register_instance_option :root do
          true
        end
      end
    end
  end
end

