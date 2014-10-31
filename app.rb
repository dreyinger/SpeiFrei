require 'sinatra'
require 'mysql2'
require 'thin'
require 'multi_json'

client = Mysql2::Client.new(:host => 'delphi3.dhbw-stuttgart.de', :username => 'speifreier', :password => 'reyinger63', :database => 'SpeiFrei')
#client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :database => 'SpeiFrei')

#use thin as web server
set :server, 'thin'

get '/' do
  erb :index
end

# post '/login.json' do
# 	puts params

# 	sql = "select * from USER where Email = '#{params[:email]}'"
# 	counter = 0

# 	results = client.query(sql, :as => :json)
# 	puts results
# 	results.map do |row|
# 	  puts row
# 	  counter += 1
# 	end
# 	if counter != 0
# 		puts "yes"
# 		return MultiJson.dump({:results => true})
# 	else
# 		puts "no"
# 		return MultiJson.dump({:results => false})
# 	end
# end

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
	
	sql = "select Firstname, Surname from DIRECTOR where PersID = #{params[:id]}"
	data = Hash.new
	
	begin 
		results = client.query(sql, :symbolize_keys => true)
	rescue Exception => e  
	  puts e.message  
	  # puts e.backtrace.inspect  
	end  
	results = results.to_a

	puts results.inspect

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
	
	if params["title"].to_s != ""
		if params["duration"]
			duration = params["duration"]
			durationInt = duration.to_i
			if durationInt != 0 # digit in duration
				if params["ageRating"]
					ageRating = params["ageRating"]
					ageRatingInt = ageRating.to_i
					if ageRatingInt != 0 # digit in ageRating
						if params["directorFirstName"]
							if params["directorSurName"]
								if (params["directorFirstName"].count " ") == 0  # no " " in firstName
									if (params["directorSurName"].count " ") == 0 # no " " in surName
										
										movieFound = false
										sql ="select Title, MovieID from MOVIE where Title = '#{params["title"]}'"
										results = client.query(sql)
										results.map do |row|
											movieFound = true
										end
											
										if !movieFound  # insert movie
											if params["studio"]
												studioFound = false
												sql = "select StudioID from STUDIO where Name = '#{params["studio"]}'"
												results = client.query(sql)
												results.map do |row|
													studioFound = true
												end
												if !studioFound # insert new studio
													sql = "INSERT INTO STUDIO (Name) VALUES ('#{params["studio"]}')"
													post = client.query(sql)
												end
												sql = "select StudioID from STUDIO where Name = '#{params["studio"]}'"
												results = client.query(sql)
												results.map do |row|
													data["StudioID"] = row["StudioID"]
												data.delete("studio")
												end
											end

											if params["directorFirstName"] && params["directorSurName"]
												sql = "select PersID from DIRECTOR where Firstname = '#{params["directorFirstName"]}' and Surname = '#{params["directorSurName"]}'"
												directorFound = false
												results = client.query(sql)
												results.map do |row|
													directorFound = true
												end
												if !directorFound # insert new director
													directorFirstName = params["directorFirstName"].capitalize
													directorSurName = params["directorSurName"].capitalize
													sql = "INSERT INTO DIRECTOR (Firstname, Surname) VALUES ('#{directorFirstName}', '#{directorSurName}')"
													#post = client.query(sql)
													sql = "select PersID from DIRECTOR where Firstname = '#{directorFirstName}' and Surname = '#{directorSurName}'"
													results = client.query(sql)
												end
												results.map do |row|
													data["D_PersID"] = row["PersID"]
												end	
												data.delete("directorFirstName") # warum?
												data.delete("directorSurName") # warum?
											end

											sql = "INSERT INTO MOVIE (Title, ReleaseDate, Genre, Mood, Duration, AgeRating, D_PersID, StudioID) VALUES ('#{data["title"]}', '#{data["releaseDate"]}', '#{data["genre"]}', '#{data["mood"]}', '#{data["duration"]}', '#{data["ageRating"]}', '#{data["D_PersID"]}', '#{data["StudioID"]}')"
											#post = client.query(sql)
										else
											puts "Movie already in DB"
										end
									else
										puts "insert ony one Surname"
									end
								else
									puts "insert only one Firstname"
								end
								
							else
								puts "no directorSurName"
							end	
								
						else
							puts "no directorFirstName"
						end
						
					else
						puts "ageRating is no digit"
					end
					
				else
					puts "no ageRating"
				end
				
			else
				puts "duration is no digit"
			end
			
		else
			puts "no duration"
		end
			
	else
		puts "no title"
	end

end

post '/api/v1/director' do
	if params["firstName"]
		if (params["firstName"].count " ") == 0 # no " " in surName
			if params["surName"]
				if (params["surName"].count " ") == 0 # no " " in surName
					sql = "select PersID from DIRECTOR where Firstname = '#{params["firstName"]}' and Surname = '#{params["surName"]}'"
					results = client.query(sql)
					if results.map.to_a[0] == nil # not in DB
						if params["birthdate"].to_s != ""
							birthdate = params["birthdate"]
							if (birthdate =~ /[[:digit:]]{4}\-[[:digit:]]{2}\-[[:digit:]]{2}/) == 0
								year = birthdate[0,4].to_i
								month = birthdate[5,2].to_i
								day = birthdate[8,2].to_i
								if year < Date.today.strftime("%Y").to_i
									if month <= 12
										if day <= 31
											if params["gender"]
												if params["gender"] == "m" || params["gender"] == "w"
													params["firstName"] = params["firstName"].capitalize
													params["surName"] = params["surName"].capitalize
													sql = "INSERT INTO DIRECTOR (Firstname, Surname, Gender) VALUES ('#{params["firstName"]}', '#{params["surName"]}', '#{params["gender"]}')"
													client.query(sql)
													if params["placeOfBirth"] || params["birthdate"]
														sql ="select PersID from DIRECTOR where Firstname = '#{params["firstName"]}' and Surname = '#{params["surName"]}'"
														results = client.query(sql).map.to_a
														persID = results[0]["PersID"]
														if params["placeOfBirth"]
															params["placeOfBirth"] = params["placeOfBirth"].capitalize
															sql = "update DIRECTOR set PlaceOfBirth = '#{params["placeOfBirth"]}' where PersID = #{persID}"
															client.query(sql)
														end
														if params["birthdate"]
															sql = "update DIRECTOR set Birthdate = '#{params["birthdate"]}' where PersID = #{persID}"
															client.query(sql)
														end
														
														# nothing in birthdate or placeOfBirth is okay
													end
												
												else
													puts "only 'm' or 'w'"
												end
												
											else
												puts "no gender"
											end

										else			
											"no valid day"
										end
										
									else
										puts "no valid month"
									end
									
								else
									puts "no valid year"
								end
								
							else
								puts "no valid pattern"
							end
						
						else
							# nothing in birthdate is okay
							if params["gender"]
								if params["gender"] == "m" || params["gender"] == "w"
									params["firstName"] = params["firstName"].capitalize
									params["surName"] = params["surName"].capitalize
									sql = "INSERT INTO DIRECTOR (Firstname, Surname, Gender) VALUES ('#{params["firstName"]}', '#{params["surName"]}', '#{params["gender"]}')"
									client.query(sql)
									if params["placeOfBirth"] || params["birthdate"]
										sql ="select PersID from DIRECTOR where Firstname = '#{params["firstName"]}' and Surname = '#{params["surName"]}'"
										results = client.query(sql).map.to_a
										persID = results[0]["PersID"]
										if params["placeOfBirth"]
											params["placeOfBirth"] = params["placeOfBirth"].capitalize
											sql = "update DIRECTOR set PlaceOfBirth = '#{params["placeOfBirth"]}' where PersID = #{persID}"
											client.query(sql)
										end
										if params["birthdate"]
											sql = "update DIRECTOR set Birthdate = '#{params["birthdate"]}' where PersID = #{persID}"
											client.query(sql)
										end
										
										# nothing in birthdate or placeOfBirth is okay
									end
								
								else
									puts "only 'm' or 'w'"
								end
								
							else
								puts "no gender"
							end
							
						end
						
					else
						puts "name in db"
					end
				
				else
					puts "only one surName"
				end
				
			else
			puts "no surName"
			end
				
		else
			puts "only one firstName"
		end
		
	else
		puts "no firstName"
	end
	
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
