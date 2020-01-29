require_relative('../db/sql_runner')

class House

  attr_reader :id
  attr_accessor :name, :logo, :student_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @logo = options['logo']
    @student_id = options['student_id'].to_i
  end

  def save()
    sql = "INSERT INTO houses(name, logo)
    VALUES ($1,$2) RETURNING id"
    values = [@name, @logo]
    student = SqlRunner.run(sql, values).first
    @id = student['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM houses;"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM houses;"
    houses = SqlRunner.run(sql)
    return houses.map { |house| House.new(house)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM houses WHERE id = $1"
    values = [id]
    house = SqlRunner.run(sql, values)[0]
    return House.new(house)
  end

end
