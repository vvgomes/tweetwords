require 'rubygems'
require 'bundler'
Bundler.require :default

configure do
  set :app_file, __FILE__
  set :public_folder, File.dirname(__FILE__)+'/../public'
  set :views, File.dirname(__FILE__)+'/views'
end

get '/' do
  erb :index
end

get %r{^\/(\w+)$} do |user|
  client = Grackle::Client.new

  begin
    tweets = client.statuses.user_timeline? :screen_name => user
    words = tweets.map(&:text).reduce([]){ |t, e| t + e.split }

    counts = words.reduce({}) do |t, e| 
      t[e] = t[e] ? t[e] + 1 : 1 ; t
    end
    
    erb :cloud, :locals => { :user => user, :counts => counts }

   rescue Grackle::TwitterError, RuntimeError => e
     puts "something went wrong: #{e.message}"
     erb :index, :locals => { :notfound => true }
   end
end

