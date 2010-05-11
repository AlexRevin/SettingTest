class Setting < ActiveRecord::Base
  serialize :value
  
  def self.method_missing(method, *args)
    method_name = method.to_s
    super(method, *args)

  rescue NoMethodError
    if method_name =~ /=$/
      self.set_variable(method_name.gsub('=', ''), args.first)
    else
      self.get_variable(method_name)
    end
  end

  def self.get_variable(method_name)
    Rails.cache.fetch(self.class_name.to_s + "_"+ method_name) {
      obj = self.find_or_initialize_by_name(:name => method_name)
      obj.value.try(:values).try(:first)
    }
  end

  def self.set_variable(method_name, value)
    obj = self.find_or_initialize_by_name(:name => method_name)
    obj.update_attribute(:value, {value.class.to_s => value})
    obj.save
    Rails.cache.write(self.class_name.to_s + "_"+ method_name, value)
    obj.value.try(:values).try(:first)
  end

  def self.all(class_name = nil)
    objs = self.find(:all, :order => 'name')
    vars = []
    for obj in objs
      vars << {obj.name => obj.value.try(:values).try(:first)} if !class_name.present? || (obj.value.has_key?(class_name) rescue false)
    end
    vars
  end

  def self.destroy(method_name)
    obj = self.find_by_name(method_name.to_s)
    obj.destroy if obj.present?
    Rails.cache.delete(self.class_name.to_s + "_"+ method_name.to_s)
    true
  end
end
