require('pg')
require_relative('../db/sql_runner.rb')

class Movie

attr_accessor :title, :genre, :budget
attr_reader :id

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget'].to_i
  end

  def save()
    sql = "INSERT INTO movies(
          title, genre, budget)
          VALUES ($1, $2, $3)
          RETURNING id"
    values = [@title, @genre, @budget]
    movie = SqlRunner.run(sql, values).first
    @id = movie['id'].to_i
  end

    def stars_in_movie()
      sql = "SELECT stars.* FROM stars INNER JOIN castings ON castings.star_id = stars.id WHERE castings.movie_id = $1"
      values = [@id]
      stars_data = SqlRunner.run(sql, values)
      stars = stars_data.map{|star|Star.new(star)}
      return stars
    end

  def update()
    sql = "UPDATE movies SET (title, genre, budget) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @genre, @budget]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM movies WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM movies"
    movies = SqlRunner.run(sql)
    results = movies.map{|movie| Movie.new(movie)}
    return results
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

end
