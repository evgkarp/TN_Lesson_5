require_relative 'maker'
require_relative 'instance_counter'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

class Main
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []  
  end

  def start
    loop do
      puts "Выберите действие:
        1 - Создать станцию
        2 - Создать поезд
        3 - Создать маршрут
        4 - Добавить станцию в маршрут
        5 - Удалить станцию из маршрута
        6 - Назначить маршрут поезду
        7 - Добавить вагон к поезду
        8 - Отцепить вагон от поезда
        9 - Переместить поезд вперед по маршруту
        10 - Переместить поезд назад по маршруту
        11 - Посмотреть список станций
        12 - Посмотреть список поездов на станции
        13 - Задать компанию-производителя поезда
        0 - Выход"

      action = gets.to_i

      break if action == 0 

      case action
        when 1
          create_station

        when 2
          create_train

        when 3
          create_route

        when 4
          station = choose_station
          route = choose_route
          route.add_station(station)

        when 5
          station = choose_station
          route = choose_route
          route.delete_station(station)

        when 6
          train = choose_train
          route = choose_route
          train.route = route

        when 7
          train = choose_train
            if train.class == PassengerTrain
              wagon = create_passenger_wagon
            else
              wagon = create_cargo_wagon                   
            end
          train.add_wagon(wagon)        

        when 8
          train = choose_train
          train.delete_wagon

        when 9
          train = choose_train
          train.go_forward

        when 10
          train = choose_train
          train.go_backward
          
        when 11
          @stations.each { |station| puts station.name }
                    
        when 12
          station = choose_station
          puts station.trains
          
        when 13
          train = choose_train
          train.maker_name = set_maker_name

        else
          puts "Введите число от 0 до 12"
      end
    end  
  end

private 

  def create_station
    puts "Введите название станции: "
    name = gets.chomp
    station = Station.new(name)
    @stations << station
  end

  def choose_station
    puts "Введите название станции"
    name = gets.chomp
    @stations.find { |station| station.name == name } 
  end

  def create_train
    type = input_type_of_train
    if type == 1
      create_passenger_train
    elsif type == 2
      create_cargo_train
    else
      puts "Введите 1 или 2"            
    end
  end

  def create_passenger_train
    number = input_number_of_train
    train = PassengerTrain.new(number)
    @trains << train
  end

  def create_cargo_train
    number = input_number_of_train
    train = CargoTrain.new(number)
    @trains << train
  end

  def input_number_of_train
    puts "Введите номер поезда: "
    number = gets.to_i
  end

  def choose_train
    number = input_number_of_train
    @trains.find { |train| train.number == number } 
  end

  def input_type_of_train
    puts "Введите тип поезда: 
    1 - Пассажирский
    2 - Грузовой"
    type = gets.to_i    
  end

  def create_route
    puts "Начальная станция: "
    start = choose_station
    puts "Конечная станция: "
    finish = choose_station
    route = Route.new(start, finish)
    @routes << route
  end

  def choose_route
    puts "Введите порядковый номер маршрута: "
    number = gets.to_i
    @routes[number - 1] 
  end

  def create_passenger_wagon
    wagon = PassengerWagon.new
  end

  def create_cargo_wagon
    wagon = CargoWagon.new
  end 

  def set_maker_name
    puts "Введите название компании: "
    name = gets.chomp    
  end
end

x = Main.new
x.start