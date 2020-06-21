require "pry"
class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = "INSERT INTO pokemon (name, type) VALUES (?, ?)"

        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id_num, db)
        sql = "SELECT * FROM pokemon WHERE id = ?"

        pokemon = db.execute(sql, id_num)

        id = pokemon[0][0]
        name = pokemon[0][1]
        type = pokemon[0][2]

        new_pokemon = self.new(id: id, name: name, type: type, db: db)
        new_pokemon
    end
end
