require "test_helper"

class StarWarsControllerTest < ActionDispatch::IntegrationTest
  test "should get films" do
    get star_wars_films_url
    assert_response :success
  end

  test "should get people" do
    get star_wars_people_url
    assert_response :success
  end

  test "should get vehicles" do
    get star_wars_vehicles_url
    assert_response :success
  end
end
