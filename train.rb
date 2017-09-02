class Train
  include Maker
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods

  attr_reader :number, :speed, :type, :wagons

  @@trains = {}

  def self.find(number)
    @@trains[number]    
  end

  def initialize(number)
    @number = number    
    @speed = 0
    @station_index = 0
    @wagons = []
    @@trains[number] = self
    register_instance
  end

  def speed_up(n)
    @speed += n if n > 0
  end

  def stop
    @speed = 0
  end

  def route=(route)
    @route = route
    @station_index = 0
    current_station.take_train(self)
  end

  def go_forward
    if last_station?
      puts "Вы на конечной станции"
    else      
      current_station.send_train(self)
      @station_index += 1
      current_station.take_train(self)
    end  
  end

  def go_backward
    if first_station?
      puts "Вы на первой станции"
    else      
      current_station.send_train(self)
      @station_index -= 1
      current_station.take_train(self)
    end  
  end

  def current_station
    @route.stations[@station_index]    
  end

  def next_station
    if last_station?
      puts "Вы на конечной станции"
    else      
      @route.stations[@station_index + 1] 
    end  
  end 
  
  def previous_station
    if first_station?
      puts "Вы на первой станции"
    else
      @route.stations[@station_index - 1]
    end     
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && self.type == wagon.type
  end

  def delete_wagon
    @wagons.pop if @speed.zero?
  end

protected

#Сюда нужно что-то поместить, поэтому помещаю нижеследующие (по мне, можно всё в паблик)
  def first_station?
    @route.stations[@station_index] == @route.stations[0]
  end

  def last_station?
    @route.stations[@station_index] == @route.stations[-1]
  end
end