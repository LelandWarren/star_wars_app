class StarWarsController < ApplicationController
  def films
    @films = Rails.cache.fetch("all_films", expires_in: 12.hours) do
      StarWarsApiService.get_films
    end
  end
  
  def show_film
    film_id = params[:id]
    cache_key = "film_#{film_id}"

    if Rails.cache.exist?(cache_key)
      logger.info "Cache hit for #{cache_key}"
    else
      logger.info "Cache miss for #{cache_key}"
    end

    # Fetch the film data, either from cache or the API
    @film = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      logger.info "Fetching data from API for film #{film_id}"
      StarWarsApiService.get_film(film_id)
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
    @person = StarWarsApiService.get_person(person_id)

    render "star_wars/show_person"
  end

  def vehicles
    @vehicles = Rails.cache.fetch("all_vehicles", expires_in: 12.hours) do
      StarWarsApiService.get_vehicles
    end
  end

  def show_vehicle
    vehicle_id = params[:id]
    @vehicle = StarWarsApiService.get_vehicle(vehicle_id)

    render "star_wars/show_vehicle"
  end
end
