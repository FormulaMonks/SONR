require 'sinatra'
require 'redis'

configure do
    REDIS_HOST = ENV['OPENSHIFT_REDIS_HOST']
    REDIS_PORT = ENV['OPENSHIFT_REDIS_PORT']
    REDIS_PW = ENV['REDIS_PASSWORD']
    REDIS = Redis.new(:host => REDIS_HOST, :port => REDIS_PORT, :password => REDIS_PW)
end


get '/' do
  "the time where this server lives is #{Time.now}
    <br /><br />check out your <a href=\"/agent\">user_agent</a>
    <br />Check out the load <a href=\"/count\">count</a>"
end

get '/agent' do
  "you're using #{request.user_agent}<br />
  Return to <a href=\"/\">top</a>"
end

get '/count' do
    REDIS.incr("count")
    count = REDIS.get("count").to_s
    "This page has been loaded #{count} times<br />
    Return to <a href=\"/\">top</a>"
end