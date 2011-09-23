require 'rubygems'
require 'bundler'
Bundler.require :default

configure do
  set :app_file, __FILE__
  set :public, File.dirname(__FILE__)+'/../public'
  set :views, File.dirname(__FILE__)+'/views'
end

get '/' do
  erb :index
end

get %r{^\/(\w+)$} do |user|
  client = Grackle::Client.new

  begin
    tweets = client.statuses.user_timeline? :screen_name => user
    text = tweets.map{ |t| t.text }.join(' ')

    params = { 'text' => text }
    resource = URI.parse 'http://www.wordle.net/advanced'
    response = Net::HTTP.post_form resource, params

    html = Nokogiri::HTML response.body
    cloud = html.css('applet').to_s
    erb :cloud, :locals => { :user => user, :cloud => cloud }

  rescue Grackle::TwitterError, RuntimeError
    erb :index, :locals => { :notfound => true }
  end
end

