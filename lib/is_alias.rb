module DanielSpangenberg::IsAlias
  def self.included(base)
    base.extend IsAlias::ClassMethods
  end

  module ClassMethods
    def is_alias(methods)
      methods.each do |name, method|
        method = name if method.class == TrueClass
        class_eval <<-METHODS, __FILE__, __LINE__ + 1
          def is_#{name.to_s}?
            self.#{method.to_s}
          end
        METHODS
      end
    end
  end
end

ActiveRecord::Base.send(:include, IsAlias)
