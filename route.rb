class Route
  include InstanceCounter
  
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)    
  end

  def delete_station(station)
    @stations.delete(station) if (station != @stations[0]) && (station != @stations[-1])  
  end
end