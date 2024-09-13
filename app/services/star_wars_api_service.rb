class StarWarsApiService
    include HTTParty
    base_uri 'https://swapi.dev/api/'
  
    # Generalized method for handling GET requests with error handling
    def self.handle_get(path)
      response = get(path)
      
      if response.success?
        response.parsed_response  # Return full parsed response
      else
        Rails.logger.error "Failed to fetch data from #{path}: #{response.code} #{response.message}"
        nil  # Return nil or handle the error as needed
      end
    end
  
    def self.get_films
      handle_get("/films")["results"]
    end
  
    def self.get_film(film_id)
      handle_get("/films/#{film_id}") 
    end
  
    def self.get_people
      handle_get("/people")["results"]
    end
  
    def self.get_person(person_id)
      handle_get("/people/#{person_id}")
    end
  
    def self.get_vehicles
      handle_get("/vehicles")["results"]
    end
  
    def self.get_vehicle(vehicle_id)
      handle_get("/vehicles/#{vehicle_id}")
    end
  end
  