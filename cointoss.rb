require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'

set :public, File.dirname(__FILE__) + '/static'

get '/' do
  erb :index
end

get '/toss' do
  doc = Nokogiri::HTML(open('http://www.random.org/integers/?num=10000&min=0&max=1&col=1&base=10&format=html&rnd=new'))

  def getCount(a, h)
    a.each { |v| h[v] += 1 }
    h
  end

  def getSide(heads, tails)
    case heads <=> tails
    when +1: "Heads."
    when  0: "Tie."
    when -1: "Tails."
    end
  end

  count = getCount(doc.css('pre.data').inner_text.split, Hash.new(0))

  @heads = count["0"]
  @tails = count["1"]

  @side = getSide(@heads, @tails)

  erb :toss
end
