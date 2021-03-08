require 'haversine'

class AirportsController < ApplicationController
  # https://stackoverflow.com/questions/7837731/units-to-use-for-maxdistance-and-mongodb
  # one degree is approximately 111.12 kilometers
  CONVERT_DISTANCE_FACTOR = 111.12

  def index
    @airports = Airport.all.limit(20)
    # TODO: future steps add pagination
    render json: @airports
  end

  def given_radius
    latitude = params[:latitude]&.to_f
    longitude = params[:longitude]&.to_f
    radius = params[:radius]&.to_f

    distance = (radius * 1.60934).fdiv(CONVERT_DISTANCE_FACTOR)

    # TODO: future steps add pagination
    # TODO: future steps add cache to enhance performance
    @airports = Airport.near_sphere(location: [latitude, longitude]).
      max_distance(location: distance)
    render json: @airports
  end

  def distance
    airport1_id = params[:airport1_id]
    airport2_id = params[:airport2_id]

    airport1 = Airport.find_by(original_id: airport1_id)
    airport2 = Airport.find_by(original_id: airport2_id)
    distance = Haversine.distance(
      airport1.location.to_a,
      airport2.location.to_a,
    )
    render json: { distance: distance.to_miles }
  end

  def closest
    country1_name = params[:country1]
    country2_name = params[:country2]

    distance = nil
    closest_airport1 = nil
    closest_airport2 = nil

    airports1 = Airport.where(country: country1_name).order_by(:location)
    airports2 = Airport.where(country: country2_name).order_by(:location)
    # O(log N) search.
    # TODO: future steps look for improvement, sort airports
    airports1.each do |airport1|
      airports2.each do |airport2|
        new_distance = Haversine.distance(airport1.location.to_a, airport2.location.to_a).to_miles
        if distance.nil? || new_distance < distance
          distance = new_distance
          closest_airport1 = airport1
          closest_airport2 = airport2
        end
      end
    end
    render json: { distance: distance, closest_airport1: closest_airport1, closest_airport2: closest_airport2 }
  end

  def shortest_route

  end
end
