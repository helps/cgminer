require 'rubygems'
require 'sinatra'
require "json"
require "redis"

redis = Redis.new
get '/' do
  @alldata = []
  @allid = []
  redis.keys("server:*").each  do |serverkey|
    serverdata = JSON.parse(redis.get(serverkey))
    @allid << serverkey
    @alldata << serverdata
  end
  erb :index
end

get '/r/:id' do
  serverid = params[:id]
  json = '{"STATUS":{"When":"1389035208","Code":"9","Msg":"1 GPU(s) - 0 ASC(s) - 0 PGA(s) - ","Description":"cgminer 3.7.2"},"GPU0":{"Enabled":"Y","Status":"Alive","Temperature":"62.00","Fan Speed":"-1","Fan Percent":"85","GPU Clock":"1050","Memory Clock":"1300","GPU Voltage":"1.138","GPU Activity":"99","Powertune":"0","MHS av":"0.35","MHS 5s":"0.35","Accepted":"228","Rejected":"4","Hardware Errors":"0","Utility":"1.28","Intensity":"17","Last Share Pool":"0","Last Share Time":"1389035186","Total MH":"3764.7811","Diff1 Work":"59100","Difficulty Accepted":"58368.00000000","Difficulty Rejected":"1024.00000000","Last Share Difficulty":"256.00000000","Last Valid Work":"1389035186","Device Hardware%":"0.0000","Device Rejected%":"1.7327","Device Elapsed":"10650"}}'
  redis.set("server:#{serverid}", json)
end
