class StarWarsController < ApplicationController

  include HTTParty
  base_uri 'https://swapi.dev/api/'


  def films
    @films = self.class.get('/films').parsed_response["results"]
  end

  def show_film
    film_id = params[:id]
    @film = self.class.get("/films/#{film_id}").parsed_response
    render partial: "film_details", locals: { film: @film }
  end

  def people
    @people = self.class.get('/people').parsed_response["results"]
  end

  def vehicles
    @vehicles = self.class.get('/vehicles').parsed_response["results"]
  end
end
