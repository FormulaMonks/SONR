require 'sinatra'
require 'redis'

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
    REDIS = Redis.new()
    REDIS.incr("count")
    count = REDIS.get("count").to_s
    "This page has been loaded #{count} times<br />
    Return to <a href=\"/\">top</a>"
end
