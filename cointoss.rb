require 'rubygems'
require 'sinatra'
require 'open-uri'

set :public, File.dirname(__FILE__) + '/static'

get '/' do
  erb :index
end

get '/toss' do
  results = open('http://www.random.org/integers/?num=10&min=0&max=1&col=1&base=10&format=plain&rnd=new').string.chop

  @heads = results.count("1")
  @tails = results.count("0")
  @last = results[-1, 1] == "1" ? "Heads" : "Tails"
  
  @side = case @heads <=> @tails
    when +1: "Heads."
    when  0: "Tie."
    when -1: "Tails."
  end

  erb :toss
end
