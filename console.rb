require('pg')
require('pry')
require_relative('models/star.rb')
require_relative('models/casting.rb')
require_relative('models/movie.rb')
require_relative('db/sql_runner.rb')

star1 = Star.new({'first_name' => 'Tom', 'last_name' => 'Hanks'})
star2 =Star.new({'first_name' => 'Mel', 'last_name' => 'Gibson'})
star1.save()
star2.save()

movie1 = Movie.new({'title' => 'Big', 'genre' => 'comedy', 'budget' => '100'})
movie2 = Movie.new({'title' => 'Citizen Cane', 'genre' => 'horror', 'budget' => '200'})
movie1.save()
movie2.save()

casting1 = Casting.new({'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => '20'})
casting2 = Casting.new({'movie_id' => movie1.id, 'star_id' => star2.id, 'fee' => '40'})
casting1.save()
casting2.save()


binding.pry
nil
