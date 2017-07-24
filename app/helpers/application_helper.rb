module ApplicationHelper

  def css_class_for_controller_action(controller)
    "#{controller.controller_path.parameterize.tr('-', '_')} #{controller.action_name}"
  end

end
