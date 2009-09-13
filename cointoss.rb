require 'rubygems'
require 'sinatra'

require 'nokogiri'
require 'open-uri'


# 

configure :production do
  # Configure stuff here you'll want to
  # only be run at Heroku at boot
  # 
  set :public, File.dirname(__FILE__) + '/static'
end


get '/' do
  @wokka = "zomgwtfbbq"
  erb :index
end

get '/hai' do
  "zomg!!!!!"
end

get '/toss' do
  require 'nokogiri'
  require 'open-uri'
  doc = Nokogiri::HTML(open('http://www.random.org/integers/?num=10&min=0&max=1&col=1&base=10&format=html&rnd=new'))

  def getCount(a, h)  
    a.each do |v|
      h[v] += 1
    end

    h.each do |k, v| end
  end

  def getSide
    if @heads > @tails
      return "Heads."
    elsif @heads < @tails
      return "Tails."
    elsif @heads == @tails
      return "Tie."
    end
  end

  count = getCount(doc.css('pre.data').inner_text.split, Hash.new(0))

  @heads = count["0"]
  @tails = count["1"]
  
  @side = getSide

  erb :toss
end