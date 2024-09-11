class StarWarsController < ApplicationController

  include HTTParty
  base_uti 'https://swapi.dev/api/'


  def films
    @films = self.class.get('/films').parsed_response["results"]
  end

  def people
    @people = self.class.get('/people').parsed_response["results"]
  end

  def vehicles
    @vehicles = self.class.get('/vehicles').parsed_response["results"]
  end
end
