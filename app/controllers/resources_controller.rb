class ResourcesController < ApplicationController
  before_action :initialize_resource_class
  before_action :check_cancancan_class_permissions

  private

  def check_cancancan_class_permissions
    unless can?(action_name&.to_sym, @resource_class)
      Rails.logger.warn("CanCanCan Permissions redirect. Invalid Access of #{controller_name}##{action_name}, class: #{@resource_class} for user IP #{request.ip} and ID #{current_user&.id}")
      redirect_to root_path, alert: "Invalid Permissions!" and return
    end
  end

  def initialize_resource_class
    # First priority is the namespaced model, e.g. User::Group
    @resource_class ||= begin
      namespaced_class = self.class.name.sub(/Controller$/, '').singularize
      namespaced_class.constantize
    rescue NameError
      nil
    end

    # Second priority is the top namespace model, e.g. EngineName::Article for EngineName::Admin::ArticlesController
    @resource_class ||= begin
      namespaced_classes = self.class.name.sub(/Controller$/, '').split('::')
      namespaced_class = [namespaced_classes.first, namespaced_classes.last].join('::').singularize
      namespaced_class.constantize
    rescue NameError
      nil
    end

    # Third priority the camelcased c, i.e. UserGroup
    @resource_class ||= begin
      camelcased_class = self.class.name.sub(/Controller$/, '').gsub('::', '').singularize
      camelcased_class.constantize
    rescue NameError
      nil
    end

    # Otherwise use the Group class, or fail
    @resource_class ||= begin
      class_name = self.controller_name.classify
      class_name.constantize
    rescue NameError => e
      raise unless e.message.include?(class_name)
      nil
    end
    # portal/portal_imports case needed this
    @resource_class ||= begin
      class_name = controller_path.classify
      class_name.camelize.singularize.constantize
    rescue NameError => e
      raise unless e.message.include?(class_name)
      nil
    end
  end
end
