require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'mongo'
require 'mongoid'
require 'sinatra/cross_origin'

configure do
  enable :cross_origin
end

Mongoid.load!("mongoid.yml")

module BSON
  class ObjectId
    alias :to_json :to_s
  end
end


class Jewel
  include Mongoid::Document
  store_in collection: "gems"
  field :name, type: String
  field :quantity, type: Integer
  field :price, type: Integer
  field :image, type: String
end

set :port, 3000
get '/gems' do
  content_type :json
  @gems = Jewel.all
  { gem: @gems }.to_json
end
