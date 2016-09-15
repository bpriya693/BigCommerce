require 'sinatra'
require 'omniauth-twitter'
require 'json'

use OmniAuth::Builder do 
	provider  :twitter, 'LoZiRP4waGtG9JUUSnEAZchZj', 'HQ8s7oIX7Le34btGMtZeSRu4LuCwZ7UcEaPfQmcGzYEEoCG7bK'
end

get '/login' do
  redirect to("/auth/twitter")
end

get '/auth/twitter/callback' do
  env['omniauth.auth'] ? session[:admin] = true : halt(401,'Not Authorized')
  "You are now logged in"
end

get '/auth/failure' do
  params[:message]
end

get '/auth/twitter/callback' do
  session[:admin] = true
  env['omniauth.auth']
end

enable :sessions

get '/query/twitter/histogram/:name' do
  session['num_tweets'] = get_number_of_tweets_for_day( params[:name] )
end

post '/histogram/:name/' do
  histogram.tweets.create(:date => time_now, :count => session['num_tweets'])
jhash = JSON.parse(num_tweets)
output = ''
jhash['main'].each do  |w|
	title_tag = w[0]
	info_item = w[1]
	output << "<tr><td>#{title_tag}</td><td>#{info_item}</td></tr>"

end
end













#get "/histogram/<name>" do 
	#@greeting_name = params[:name]
	#{}"Hello #{@greeting_name}"
#end 

