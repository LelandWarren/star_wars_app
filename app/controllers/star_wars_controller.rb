class StarWarsController < ApplicationController

  include HTTParty
  base_uri 'https://swapi.dev/api/'


  def films
    @films = self.class.get('/films').parsed_response["results"]
  end

  def show_film
    film_id = params[:id]
    @film = self.class.get("/films/#{film_id}").parsed_response

    render turbo_stream: turbo_stream.replace("films-frame", partial: "film_details", locals: { film: @film })
  end

  def people
    @people = self.class.get('/people').parsed_response["results"]
  end

  def show_person
    person_id = params[:id]
    @person = self.class.get("/people/#{person_id}").parsed_response
    render partial: "person_details", locals: { person: @person }
  end

  def vehicles
    @vehicles = self.class.get('/vehicles').parsed_response["results"]
  end

  def show_vehicle
    vehicle_id = params[:id]
    @vehicle = self.class.get("/vehicles/#{vehicle_id}").parsed_response
    render partial: "vehicle_details", locals: { vehicle: @vehicle }
  end
  
end
