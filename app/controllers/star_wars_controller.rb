class StarWarsController < ApplicationController
  def films
    @films = Rails.cache.fetch("all_films", expires_in: 12.hours) do
      StarWarsApiService.get_films
    end
  end
  
  def show_film
    film_id = params[:id]
    
    @film = Rails.cache.fetch("film_#{film_id}", expires_in: 12.hours) do
      StarWarsApiService.get_film(film_id)
    end
  
    # Fetch related characters (people) and cache the full object
    @characters = @film["characters"].map do |url|
      character_id = url.split("/").last
      Rails.cache.fetch("person_#{character_id}", expires_in: 12.hours) do
        StarWarsApiService.get_person(character_id)
      end
    end
  
    # Fetch related vehicles and cache the full object
    @vehicles = @film["vehicles"].map do |url|
      vehicle_id = url.split("/").last
      Rails.cache.fetch("vehicle_#{vehicle_id}", expires_in: 12.hours) do
        StarWarsApiService.get_vehicle(vehicle_id)
      end
    end
  
    render "star_wars/show_film"
  end
  
  
  def people
    @people = Rails.cache.fetch("all_people", expires_in: 12.hours) do
      StarWarsApiService.get_people
    end
  end

  def show_person
    person_id = params[:id]
    
    @person = Rails.cache.fetch("person_#{person_id}", expires_in: 12.hours) do
      StarWarsApiService.get_person(person_id)
    end
  
    # Fetch related films and cache the full object
    @films = @person["films"].map do |url|
      film_id = url.split("/").last
      Rails.cache.fetch("film_#{film_id}", expires_in: 12.hours) do
        StarWarsApiService.get_film(film_id)
      end
    end
  
    render "star_wars/show_person"
  end
  
  

  def vehicles
    @vehicles = Rails.cache.fetch("all_vehicles", expires_in: 12.hours) do
      StarWarsApiService.get_vehicles
    end
  end

  def show_vehicle
    vehicle_id = params[:id]
    
    @vehicle = Rails.cache.fetch("vehicle_#{vehicle_id}", expires_in: 12.hours) do
      StarWarsApiService.get_vehicle(vehicle_id)
    end
  
    # Fetch related pilots
    @pilots = @vehicle["pilots"].map do |url|
      pilot_id = url.split("/").last
      Rails.cache.fetch("person_#{pilot_id}", expires_in: 12.hours) do
        StarWarsApiService.get_person(pilot_id)
      end
    end
  
    # Fetch related films
    @films = @vehicle["films"].map do |url|
      film_id = url.split("/").last
      Rails.cache.fetch("film_#{film_id}", expires_in: 12.hours) do
        StarWarsApiService.get_film(film_id)
      end
    end
  
    render "star_wars/show_vehicle"
  end
  
end
