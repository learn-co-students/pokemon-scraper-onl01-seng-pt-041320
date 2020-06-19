class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

 def initialize(name:, type:, db:, id:)
   @name = name
   @type = type
   @db = db
   @id = id
 end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?);
    SQL

    db.execute(sql, [name, type])

  end

  def self.find(id, db)
      statement = db.prepare("SELECT * FROM pokemon WHERE id = ?")
      result_set = statement.execute(id)

      results = result_set.collect do |row|
        pokemon = Pokemon.new(name: row[1], type: row[2], db: db, id: id)
        pokemon.hp = row[3]
        pokemon
      end
      results[0]
    end

  def alter_hp(new_hp)
    sql = <<-SQL
      UPDATE pokemon SET hp = ? WHERE id = ?;
    SQL
    db.execute(sql, [new_hp, id])
    end
end
