class Wagon
  include Maker
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods

  attr_reader :type

  def initialize
    register_instance
  end
end
