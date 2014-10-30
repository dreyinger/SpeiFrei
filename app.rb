require 'sinatra'
require 'mysql2'
require 'thin'
require 'multi_json'

# client = Mysql2::Client.new(:host => 'delphi3.dhbw-stuttgart.de', :username => 'speifreier', :password => 'reyinger63', :database => 'SpeiFrei')
client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :database => 'SpeiFrei')

#use thin as web server
set :server, 'thin'

get '/' do
  erb :index
end

post '/login.json' do
	puts params

	sql = "select * from USER where Email = '#{params[:email]}'"
	counter = 0

	results = client.query(sql, :as => :json)
	puts results
	results.map do |row|
	  puts row
	  counter += 1
	end
	if counter != 0
		puts "yes"
		return MultiJson.dump({:results => true})
	else
		puts "no"
		return MultiJson.dump({:results => false})
	end
end

get '/api/v1/movies' do
	content_type :json

	sql = "select * from MOVIE"	
	data = Array.new

	results = client.query(sql, :symbolize_keys => true).each do |row|
	  data.push(row)
	end

	MultiJson.dump(data)
end

get '/api/v1/studios' do
	content_type :json

	sql = "select * from STUDIO"	
	data = Array.new

	results = client.query(sql, :symbolize_keys => true).each do |row|
	  data.push(row)
	end

	MultiJson.dump(data)
end

get '/api/v1/actors' do
	content_type :json

	sql = "select * from ACTOR"	
	data = Array.new

	results = client.query(sql, :symbolize_keys => true).each do |row|
	  data.push(row)
	end

	MultiJson.dump(data)
end

get '/api/v1/directors' do
	content_type :json

	sql = "select * from DIRECTOR"	
	data = Array.new

	results = client.query(sql, :symbolize_keys => true).each do |row|
	  data.push(row)
	end

	MultiJson.dump(data)
end

get '/api/v1/studio/:id' do
	content_type :json
	
	sql = "select StudioID, Name from STUDIO where StudioID = #{params[:id]}"
	data = Array.new

	results = client.query(sql, :symbolize_keys => true).each do |row|
	  data.push(row)
	end

	MultiJson.dump(data)
end

get '/api/v1/actor/:id' do
	content_type :json
	
	sql = "select * from ACTOR where PersID = #{params[:id]}"
	data = Array.new

	results = client.query(sql, :symbolize_keys => true).each do |row|
	  data.push(row)
	end

	MultiJson.dump(data)
end

get '/api/v1/director/:id' do
	content_type :json
	
	sql = "select * from DIRECTOR where PersID = #{params[:id]}"
	data = Array.new

	results = client.query(sql, :symbolize_keys => true).each do |row|
	  data.push(row)
	end

	MultiJson.dump(data)
end

get '/api/v1/movie/:id' do
	content_type :json
	
	sql = "select * from MOVIE where MovieID = #{params[:id]}"
	data = Array.new

	results = client.query(sql, :symbolize_keys => true).each do |row|
	  data.push(row)
	end

	MultiJson.dump(data)
end

post '/api/v1/movie' do
	data = params
	puts data
	if params["studio"]
		sql = "select StudioID from STUDIO where Name = '#{params["studio"]}'"
		results = client.query(sql)
		results.map do |row|
		  data["StudioID"] = row["StudioID"]
		end
		data.delete("studio")
	end

	if params["directorFirstName"] && params["directorSurName"]
		sql = "select PersID from DIRECTOR where Firstname = '#{params["directorFirstName"]}' and Surname = '#{params["directorSurName"]}'"
		results = client.query(sql)
		results.map do |row|
		  data["D_PersID"] = row["PersID"]
		end
		data.delete("directorFirstName")
		data.delete("directorSurName")
	end

	sql = "INSERT INTO MOVIE (Title, ReleaseDate, Genre, Mood, Duration, AgeRating, D_PersID, StudioID) VALUES ('#{data["title"]}', '#{data["releaseDate"]}', '#{data["genre"]}', '#{data["mood"]}', '#{data["duration"]}', '#{data["ageRating"]}', '#{data["D_PersID"]}', '#{data["StudioID"]}')"
	post = client.query(sql)
	puts post
	# puts data
end

# post '/api/v1/movie' do
# 	data = params
# 	puts data
# 	if params[:studio]
# 		sql = "select StudioID from STUDIO where Name = '#{params[:studio]}'"
# 		results = client.query(sql)
# 		results.map do |row|
# 		  data["studio"] = row[:StudioID]
# 		end
# 	end

# 	puts data
# end
