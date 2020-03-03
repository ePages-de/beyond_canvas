# frozen_string_literal: true

module BeyondCanvas
  class Engine < ::Rails::Engine
    isolate_namespace BeyondCanvas

    initializer 'local_helper.action_controller' do
      ActiveSupport.on_load :action_controller do
        helper BeyondCanvas::ApplicationHelper
        helper BeyondCanvas::LocaleSwitchHelper
      end
    end
  end
end
