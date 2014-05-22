require 'sinatra'
require 'csv'
require 'pry'

def csv_data(file)
  league_arr = []

  CSV.foreach(file, headers: true) do |row|
    # Instantiate hash for each player and populate info from our CSV row indices
    player = {}
      player[:f_name] = row[0].downcase
      player[:l_name] = row[1].downcase
      player[:position] = row[2].downcase
      player[:team] = row[3].downcase
    # Append to our leage array
    league_arr << player
  end
  league_arr
end

def find_teams(league)
  teams = []
  league.each do |player|
    teams << player[:team]
  end
  uniq_teams = teams.uniq!
end

def find_positions(league)
  positions = []
  league.each do |player|
    positions << player[:position]
  end
  uniq_positions = positions.uniq!
end

def players_for_team(league, team)
 league.select { |player| player[:team] == team }
end

def players_for_position(league, position)
   @league.select { |player| player[:position] == position }
end
################################################################
################################################################

before do
  filename = 'roster.csv'
  @league = csv_data(filename)
end

set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
  # filename = 'roster.csv'
  # @league = csv_data(filename)
  @teams = find_teams(@league)
  @positions = find_positions(@league)

  erb :index
end

# get '/' do

# #here's where that line was
#   erb :index
# end

get '/test' do
 'Hello world!'
end

get '/teams/:team' do
  # filename = 'roster.csv'
  # @league = csv_data(filename)
  # @teams = find_teams(@league)
  @team_name = params[:team]
  @squad = players_for_team(@league, @team_name)

  erb :'/teams/show'
end

get '/positions/:position' do
  # filename = 'roster.csv'
  # @league = csv_data(filename)
  @position_name = params[:position]
  @position = players_for_position(@league, @position_name)

erb :'/positions/show'
end




# puts players_for_team("simpson slammers")
# puts players_for_team("jetson jets")
# puts players_for_team("flinestone fire")
# puts players_for_team("griffin goats")

# players_for_position("catcher")
# players_for_position("pitcher")
# players_for_position("1st base")
# players_for_position("2nd base")
# players_for_position("3rd base")
# players_for_position("shortstop")
# players_for_position("right field")
# players_for_position("center field")
# players_for_position("left field")









