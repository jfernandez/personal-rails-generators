class ControllerSpecGenerator < Rails::Generator::NamedBase

  def manifest
    record do |m|
      m.template "controller_spec.rb", "spec/controllers/#{plural_name}_controller_spec.rb"
    end
  end
  
  def plural_class_name
    plural_name.camelize
  end
  
  def human_name
    class_name.titleize
  end

end