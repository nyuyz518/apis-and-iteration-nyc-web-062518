require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  character_data = character_hash["results"].find { |data| data["name"] == character }
  film_urls = character_data["films"]
  film_data = film_urls.collect { |data| JSON.parse(RestClient.get(data)) }
  film_data
end

  films_hash = get_character_movies_from_api("Luke Skywalker")
def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each.with_index(1) do |data, index|
  puts "#{index} " + data['title']
  end
end
parse_character_movies(films_hash)

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
show_character_movies("Luke Skywalker")
