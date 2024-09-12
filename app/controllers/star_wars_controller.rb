class StarWarsController < ApplicationController

  include HTTParty
  base_uri 'https://swapi.dev/api/'


  def films
    @films = Rails.cache.fetch("all_films", expires_in: 12.hours) do
      self.class.get("/films").parsed_response["results"]
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
      self.class.get("/films/#{film_id}").parsed_response
    end

    # Render the full page for the film details
    render "star_wars/show_film"
  end
  
  
  

  def people
    @people = self.class.get('/people').parsed_response["results"]
  end

  def show_person
    person_id = params[:id]
    @person = self.class.get("/people/#{person_id}").parsed_response
  
    render "star_wars/show_person"
  end

  def vehicles
    @vehicles = self.class.get('/vehicles').parsed_response["results"]
  end

  def show_vehicle
    vehicle_id = params[:id]
    @vehicle = self.class.get("/vehicles/#{vehicle_id}").parsed_response

    render "star_wars/show_vehicle"
  end

  
end
