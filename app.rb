require 'rubygems'
require 'sinatra'
require 'mysql2'
require 'active_record'
require 'thin'
require 'multi_json'

client = Mysql2::Client.new(:host => 'delphi3.dhbw-stuttgart.de', :username => 'speifreier', :password => 'reyinger63', :database => 'SpeiFrei')
#client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :database => 'SpeiFrei')

#use thin as web server
set :server, 'thin'

get '/' do
  erb :index
end

get '/api/v1/user' do
	sql = "select Email from USER where Email = '#{params[:email]}' and Password = '#{params[:password]}'"

	results = client.query(sql, :symbolize_keys => true)
	data = results.to_a

	data.length == 1 ? data = {"auth" => true} : data = {"auth" => false}

	MultiJson.dump(data)
end

get '/api/v1/movies' do
	content_type :json

	sql = "select * from MOVIE"

	results = client.query(sql, :symbolize_keys => true)
	data = results.to_a

	MultiJson.dump(data)
end

get '/api/v1/studios' do
	content_type :json

	sql = "select * from STUDIO"	

	results = client.query(sql, :symbolize_keys => true)

	data = results.to_a

	MultiJson.dump(data)
end

get '/api/v1/actors' do
	content_type :json

	sql = "select * from ACTOR"	

	results = client.query(sql, :symbolize_keys => true)
	data = results.to_a

	MultiJson.dump(data)
end

get '/api/v1/directors' do
	content_type :json

	sql = "select * from DIRECTOR order by Surname"	

	results = client.query(sql, :symbolize_keys => true)
	data = results.to_a

	MultiJson.dump(data)
end

get '/api/v1/studio/:id' do
	content_type :json
	
	sql = "select * from STUDIO where StudioID = #{params[:id]}"
	results = client.query(sql, :symbolize_keys => true)
	data = results.to_a

	MultiJson.dump(data)
end

get '/api/v1/actor/:id' do
	content_type :json
	
	sql = "select * from ACTOR where PersID = #{params[:id]}"

	results = client.query(sql, :symbolize_keys => true)
	data = results.to_a

	MultiJson.dump(data)
end

get '/api/v1/director/:id' do
	content_type :json
	
	sql = "select * from DIRECTOR where PersID = #{params[:id]}"
	
	results = client.query(sql, :symbolize_keys => true)
	data = results.to_a

	MultiJson.dump(data)
end

get '/api/v1/movie/:id' do
	content_type :json
	
	sql = "select * from MOVIE where MovieID = #{params[:id]}"

	results = client.query(sql, :symbolize_keys => true)
	data = results.to_a

	MultiJson.dump(data)
end

post '/api/v1/createUser' do
	sql = "select Email from USER where Email = '#{params["email"]}'"
	results = client.query(sql, :symbolize_keys => true)
	data = results.to_a

	if data.length == 0
		sql = "INSERT INTO USER (Email, Password, Firstname, Surname"

		params["birthdate"] ? (sql += ", Birthdate") : nil
		params["gender"] ? (sql += ", Gender") : nil

		sql += ") VALUES ('#{params["email"]}', '#{params["password"]}', '#{params["firstname"]}', '#{params["surname"]}'"

		params["birthdate"] ? (sql += ", '#{params["birthdate"]}'") : nil
		params["gender"] ? (sql += ", '#{params["gender"]}'") : nil

		sql += ")"

		results = client.query(sql, :symbolize_keys => true)
		data = {:created => true}
	else
		data = {:created => false}
	end
	MultiJson.dump(data)
end

post '/api/v1/createMovie' do
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
													post = client.query(sql)
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
											post = client.query(sql)
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

post '/api/v1/createDirector' do
	alreadyInDB = true
	validFirstName = false
	validSurName = false
	validPlaceOfBirth = true
	validBirthdate = true
	validGender = false

	if params["firstName"] && params["firstName"] != ""
		if (params["firstName"].count " ") == 0 # no " " in surName
			if (params["firstName"] =~ /[[:upper:]]/) == 0
				validFirstName = true
			else
				puts "firstName must start with upper case"
			end
		else
			puts "only one firstName"
		end
	else
		puts "no firstName"
	end
	
	if params["surName"] && params["surName"] != ""
		if (params["surName"].count " ") == 0 # no " " in surName
			if (params["surName"] =~ /[[:upper:]]/) == 0
				validSurName = true			
			else
				puts "surName must start with upper case"
			end
		else
			puts "only one surName"
		end
	else
		puts "no surName"
	end
	
	if validFirstName && validSurName
		sql = "select PersID from DIRECTOR where Firstname = '#{params["firstName"]}' and Surname = '#{params["surName"]}'"
		results = client.query(sql)
		if results.map.to_a[0] == nil # not in DB
			alreadyInDB = false
		else
			puts "already in DB"
		end
	end
	
	if params["placeOfBirth"] != nil && params["placeOfBirth"] != ""
		if (params["placeOfBirth"] =~ /[[:upper:]]/) != 0 # no upper case character in PlaceOfBirth[0]
			puts "placeOfBirth must start with an upper case"
			validPlaceOfBirth = false
		end
		
		if (params["placeOfBirth"] =~ /[[:digit:]]/) != nil # no digit in PlaceOfBirth
			puts "only Characters in placeOfBirth"
			validPlaceOfBirth = false
		end
	end
		
	if params["birthdate"] && params["birthdate"] != ""
		if (params["birthdate"] =~ /[[:digit:]]{4}\-[[:digit:]]{2}\-[[:digit:]]{2}/) != 0
			year = params["birthdate"][0,4].to_i
			month = params["birthdate"][5,2].to_i
			day = params["birthdate"][8,2].to_i
			if year > Date.today.strftime("%Y").to_i
				if month > 12
					if day > 31	
						puts "no valid day"
						validBirthdate = false
					end
					puts "no valid month"
					validBirthdate = false
				end
				puts "no valid year"
				validBirthdate = false
			end
			puts "no valid birthdate pattern"
			validBirthdate = false
		end
	end
		
	if params["gender"] == "m" || params["gender"] == "w"
		validGender = true
	else
		puts "no valid gender"
	end
	
	if validFirstName && validSurName && validGender && !alreadyInDB && validBirthdate && validPlaceOfBirth
		sql = "INSERT INTO DIRECTOR (Firstname, Surname, Gender) VALUES ('#{params["firstName"]}', '#{params["surName"]}', '#{params["gender"]}')"
		client.query(sql)
		if validBirthdate || validPlaceOfBirth
			sql ="select PersID from DIRECTOR where Firstname = '#{params["firstName"]}' and Surname = '#{params["surName"]}'"
			results = client.query(sql).map.to_a
			persID = results[0]["PersID"]
			if params["birthdate"]
				sql = "update DIRECTOR set Birthdate = '#{params["birthdate"]}' where PersID = #{persID}"
				client.query(sql)
			end
			if params["placeOfBirth"]
				sql = "update DIRECTOR set PlaceOfBirth = '#{params["placeOfBirth"]}' where PersID = #{persID}"
				client.query(sql)
			end
		end			
	end
end

post '/api/v1/editDirector' do
	persID = 1000
	if params["newFirstName"] != nil && params["newFirstName"] != ""
		if (params["newFirstName"].count " ") == 0 # no " " in surName
			if (params["newFirstName"] =~/[[:upper:]]/) == 0
				sql = "update DIRECTOR set Firstname = '#{params["newFirstName"]}' where PersID = #{persID}"
				client.query(sql)
			else
				puts "firstName must start with upper case"
			end
		else
			puts "only one firstName"
		end
	end
	
	if params["newSurName"] != nil && params["newSurName"] != ""
		if (params["newSurName"].count " ") == 0 # no " " in surName
			if (params["newSurName"] =~/[[:upper:]]/) == 0
				sql = "update DIRECTOR set Surname = '#{params["newSurName"]}' where PersID = #{persID}"
				client.query(sql)
			else
				puts "surName must start with upper case"
			end
		else
			puts "only one surName"
		end
	end
	
	if params["newPlaceOfBirth"] && params["newPlaceOfBirth"] != ""
		validPlaceOfBirth = true
		if (params["newPlaceOfBirth"] =~ /[[:upper:]]/) != 0 # no upper case character in PlaceOfBirth[0]
			puts "placeOfBirth must start with an upper case"
			validPlaceOfBirth = false
		end
		
		if (params["newplaceOfBirth"] =~ /[[:digit:]]/) != nil # no digit in PlaceOfBirth
			puts "only Characters in placeOfBirth"
			validPlaceOfBirth = false
		end
		
		if validPlaceOfBirth
			sql = "update DIRECTOR set PlaceOfBirth = '#{params["newplaceOfBirth"]}' where PersID = #{persID}"
			client.query(sql)
		end
	end
	
	if params["newBirthdate"] && params["newBirthdate"] != ""
		validBirthdate = true
		if (params["newBirthdate"] =~ /[[:digit:]]{4}\-[[:digit:]]{2}\-[[:digit:]]{2}/) != 0
			year = params["newBirthdate"][0,4].to_i
			month = params["newBirthdate"][5,2].to_i
			day = params["newBirthdate"][8,2].to_i
			if year > Date.today.strftime("%Y").to_i
				if month > 12
					if day > 31	
						puts "no valid day"
						validBirthdate = false
					end
					puts "no valid month"
					validBirthdate = false
				end
				puts "no valid year"
				validBirthdate = false
			end
			puts "no valid newBirthdate pattern"
			validBirthdate = false
		end
		if validBirthdate
			sql = "update DIRECTOR set Birthdate = '#{params["newBirthdate"]}' where PersID = #{persID}"
			client.query(sql)
		end
	end
	
	if params["newGender"] && params["newGender"]
		if params["newGender"] == "m" || params["newGender"] == "w"
			sql = "update DIRECTOR set Gender = '#{params["newGender"]}' where PersID = #{persID}"
			client.query(sql)
		else
			puts "only 'm' or 'w'"
		end
	end
end

post '/api/v1/deleteDirector' do
	sql = "select PersID from DIRECTOR where PersID = #{params[:PersID]}"
	results = client.query(sql)
	if results.to_a.length > 0
		sql = "delete from DIRECTOR where PersID = #{params[:PersID]}"
		results = client.query(sql)
		return MultiJson.dump({:deleted => true})
	else

		return MultiJson.dump({:deleted => false})
	end
end

post '/api/v1/deleteActor' do
	sql = "select PersID from ACTOR where PersID = #{params[:PersID]}"
	results = client.query(sql)
	if results.to_a.length > 0
		sql = "delete from ACTOR where PersID = #{params[:PersID]}"
		results = client.query(sql)
		return MultiJson.dump({:deleted => true})
	else

		return MultiJson.dump({:deleted => false})
	end
end

post '/api/v1/createActor' do
	alreadyInDB = true
	validFirstName = false
	validSurName = false
	validPlaceOfBirth = true
	validBirthdate = true
	validGender = false
	
	if params["firstName"] && params["firstName"] != ""
		if (params["firstName"].count " ") == 0 # no " " in surName
			if (params["firstName"] =~ /[[:upper:]]/) == 0
				validFirstName = true
			else
				puts "firstName must start with upper case"
			end
		else
			puts "only one firstName"
		end
	else
		puts "no firstName"
	end
	
	if params["surName"] && params["surName"] != ""
		if (params["surName"].count " ") == 0 # no " " in surName
			if (params["surName"] =~ /[[:upper:]]/) == 0
				validSurName = true			
			else
				puts "surName must start with upper case"
			end
		else
			puts "only one surName"
		end
	else
		puts "no surName"
	end
	
	if validFirstName && validSurName
		sql = "select PersID from ACTOR where Firstname = '#{params["firstName"]}' and Surname = '#{params["surName"]}'"
		results = client.query(sql)
		if results.map.to_a[0] == nil # not in DB
			alreadyInDB = false
		else
			puts "already in DB"
		end
	end
	
	if params["placeOfBirth"] != nil && params["placeOfBirth"] != ""
		if (params["placeOfBirth"] =~ /[[:upper:]]/) != 0 # no upper case character in PlaceOfBirth[0]
			puts "placeOfBirth must start with an upper case"
			validPlaceOfBirth = false
		end
		
		if (params["placeOfBirth"] =~ /[[:digit:]]/) != nil # no digit in PlaceOfBirth
			puts "only Characters in placeOfBirth"
			validPlaceOfBirth = false
		end
	end
		
	if params["birthdate"] && params["birthdate"] != ""
		if (params["birthdate"] =~ /[[:digit:]]{4}\-[[:digit:]]{2}\-[[:digit:]]{2}/) != 0
			year = params["birthdate"][0,4].to_i
			month = params["birthdate"][5,2].to_i
			day = params["birthdate"][8,2].to_i
			if year > Date.today.strftime("%Y").to_i
				if month > 12
					if day > 31	
						puts "no valid day"
						validBirthdate = false
					end
					puts "no valid month"
					validBirthdate = false
				end
				puts "no valid year"
				validBirthdate = false
			end
			puts "no valid birthdate pattern"
			validBirthdate = false
		end
	end
		
	if params["gender"] == "m" || params["gender"] == "w"
		validGender = true
	else
		puts "no valid gender"
	end
	
	if validFirstName && validSurName && validGender && !alreadyInDB && validBirthdate && validPlaceOfBirth
		sql = "INSERT INTO ACTOR (Firstname, Surname, Gender) VALUES ('#{params["firstName"]}', '#{params["surName"]}', '#{params["gender"]}')"
		client.query(sql)
		if validBirthdate || validPlaceOfBirth
			sql ="select PersID from ACTOR where Firstname = '#{params["firstName"]}' and Surname = '#{params["surName"]}'"
			results = client.query(sql).map.to_a
			persID = results[0]["PersID"]
			if params["birthdate"]
				sql = "update ACTOR set Birthdate = '#{params["birthdate"]}' where PersID = #{persID}"
				client.query(sql)
			end
			if params["placeOfBirth"]
				sql = "update ACTOR set PlaceOfBirth = '#{params["placeOfBirth"]}' where PersID = #{persID}"
				client.query(sql)
			end
		end			
	end
end

post '/api/v1/editActor' do
	persID = 1000
	if params["newFirstName"] != nil && params["newFirstName"] != ""
		if (params["newFirstName"].count " ") == 0 # no " " in surName
			if (params["newFirstName"] =~/[[:upper:]]/) == 0
				sql = "update ACTOR set Firstname = '#{params["newFirstName"]}' where PersID = #{persID}"
				client.query(sql)
			else
				puts "firstName must start with upper case"
			end
		else
			puts "only one firstName"
		end
	end
	
	if params["newSurName"] != nil && params["newSurName"] != ""
		if (params["newSurName"].count " ") == 0 # no " " in surName
			if (params["newSurName"] =~/[[:upper:]]/) == 0
				sql = "update ACTOR set Surname = '#{params["newSurName"]}' where PersID =  #{persID}"
				client.query(sql)
			else
				puts "surName must start with upper case"
			end
		else
			puts "only one surName"
		end
	end
	
	if params["newPlaceOfBirth"] && params["newPlaceOfBirth"] != ""
		validPlaceOfBirth = true
		if (params["newPlaceOfBirth"] =~ /[[:upper:]]/) != 0 # no upper case character in PlaceOfBirth[0]
			puts "placeOfBirth must start with an upper case"
			validPlaceOfBirth = false
		end
		
		if (params["newplaceOfBirth"] =~ /[[:digit:]]/) != nil # no digit in PlaceOfBirth
			puts "only Characters in placeOfBirth"
			validPlaceOfBirth = false
		end
		
		if validPlaceOfBirth
			sql = "update ACTOR set PlaceOfBirth = '#{params["newplaceOfBirth"]}' where PersID =  #{persID}"
			client.query(sql)
		end
	end
	
	if params["newBirthdate"] && params["newBirthdate"] != ""
		validBirthdate = true
		if (params["newBirthdate"] =~ /[[:digit:]]{4}\-[[:digit:]]{2}\-[[:digit:]]{2}/) != 0
			year = params["newBirthdate"][0,4].to_i
			month = params["newBirthdate"][5,2].to_i
			day = params["newBirthdate"][8,2].to_i
			if year > Date.today.strftime("%Y").to_i
				if month > 12
					if day > 31	
						puts "no valid day"
						validBirthdate = false
					end
					puts "no valid month"
					validBirthdate = false
				end
				puts "no valid year"
				validBirthdate = false
			end
			puts "no valid newBirthdate pattern"
			validBirthdate = false
		end
		if validBirthdate
			sql = "update ACTOR set Birthdate = '#{params["newBirthdate"]}' where PersID =  '#{persID}'"
			client.query(sql)
		end
	end
	
	if params["newGender"] && params["newGender"]
		if params["newGender"] == "m" || params["newGender"] == "w"
			sql = "update ACTOR set Gender = '#{params["newGender"]}' where PersID =  #{persID}"
			client.query(sql)
		else
			puts "only 'm' or 'w'"
		end
	end
end

post '/api/v1/createStudio' do
	alreadyInDB = true
	validName = false
	validHeadquater = true
	
	if params["name"] && params["name"] != ""
		if (params["name"].count " ") == 0 # no " " in surName
			if (params["name"] =~ /[[:upper:]]/) == 0
				validName = true
			else
				puts "name must start with upper case"
			end
		else
			puts "only one name"
		end
	else
		puts "no name"
	end
	
	if validName
		sql = "select StudioID from STUDIO where Name = '#{params["name"]}'"
		results = client.query(sql)
		if results.map.to_a[0] == nil # not in DB
			alreadyInDB = false
		else
			puts "already in DB"
		end
	end
	
	if params["headquarter"] != nil && params["headquarter"] != ""
		if (params["headquarter"] =~ /[[:upper:]]/) != 0 # no upper case character in PlaceOfBirth[0]
			puts "headquarter must start with an upper case"
			validHeadquater = false
		end
	end
	
	if validName && !alreadyInDB && validHeadquater
		sql = "INSERT INTO STUDIO (Name, Headquarter) VALUES ('#{params["name"]}', '#{params["headquarter"]}')"
		client.query(sql)
		if validHeadquater
			sql ="select StudioID from STUDIO where Name = '#{params["name"]}'"
			results = client.query(sql).map.to_a
			studioID = results[0]["StudioID"]
			sql = "update STUDIO set Headquarter = '#{params["headquarter"]}' where StudioID = #{studioID}"
			client.query(sql)
		end			
	end	
end

post '/api/v1/editStudio' do

	if params["newName"] != nil && params["newName"] != ""
		if (params["newName"] =~/[[:upper:]]/) == 0
				sql = "update STUDIO set Name = '#{params["newName"]}' where StudioID = #{params["studioID"]}"
				client.query(sql)
		else
			puts "name must start with upper case"
		end
	end


	
	if params["newHeadquarter"] != nil && params["newHeadquarter"] != ""
		if (params["newHeadquarter"] =~/[[:upper:]]/) == 0
			sql = "update STUDIO set Headquarter = '#{params["newHeadquarter"]}' where StudioID = #{params["studioID"]}"
			client.query(sql)
		else
			puts "name must start with upper case"
		end
	end
end

post '/api/v1/deleteMovie' do
	sql = "select MovieID from MOVIE where MovieID = #{params[:MovieID]}"
	results = client.query(sql)
	if results.to_a.length > 0
		sql = "delete from MOVIE where MovieID = #{params[:MovieID]}"
		results = client.query(sql)
		return MultiJson.dump({:deleted => true})
	else

		return MultiJson.dump({:deleted => false})
	end
end

post '/api/v1/deleteStudio' do
	sql = "select StudioID from STUDIO where StudioID = #{params[:StudioID]}"
	results = client.query(sql)
	if results.to_a.length > 0
		sql = "delete from STUDIO where StudioID = #{params[:StudioID]}"
		results = client.query(sql)
		return MultiJson.dump({:deleted => true})
	else
		return MultiJson.dump({:deleted => false})
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
