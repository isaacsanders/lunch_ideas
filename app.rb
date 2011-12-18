require 'json'
require 'sinatra'
require 'data_mapper'
require_relative './config'
require 'pp'

class LunchIdeasApp < Sinatra::Application
  set :environment, (ENV['APP_ENV'] || :development)
  set :app_file, __FILE__

  get '/' do
    redirect '/index.html'
  end

  require_relative './app/models/idea'
  get '/ideas' do
    ideas = Idea.all
    content_type :json
    ideas.to_json
  end

  put '/ideas/:id' do
    json = JSON.parse(params["model"])
    if idea = Idea.get(params[:id])
      idea.update(json)
    end
  end

  post '/ideas' do
    json = JSON.parse(params["model"])
    pp json
    idea = Idea.create(json)
    p idea.save
    content_type :json
    "/ideas/#{idea.id}"
  end

  get '/ideas/:id' do
    pp params
    idea = Idea.get(Integer(params[:id]))
    content_type :json
    idea.to_json
  end

  put '/ideas/:id' do
    Idea.update(params['idea'])
  end

  delete '/ideas/:id' do
    idea = Idea.get!(params[:id])
    idea.destroy
  end

  DataMapper.finalize
end
