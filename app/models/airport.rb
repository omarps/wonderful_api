class Airport
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial

  field :original_id, type: Integer
  field :name, type: String
  field :city, type: String
  field :country, type: String
  field :iata_faa, type: String
  field :icao, type: String
  field :location, type: Point, spatial: true
  field :altitude, type: Integer
  field :timezone, type: String

  spatial_index :location
  spatial_scope :location

  index({ original_id: 1 })
end
