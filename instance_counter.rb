module InstanceCounter
  module ClassMethods
      @@instances = 0

    def instances
      @@instances    
    end

    def instance_increment
      @@instances += 1
    end
  end

  module InstanceMethods

    protected
    
    def register_instance
      self.class.instance_increment
    end
  end
end