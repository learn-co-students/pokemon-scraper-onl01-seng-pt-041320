

class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(name:, type:, db:, id:)
    @id = id
    @name = name
    @type = type 
    @db = db
  end

  

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?);", name, type)
    #sql = <<-SQL
    #INSERT INTO pokemon (name, type, db) VALUES (?, ?, ?)
    #SQL
    #DB[:conn].execute(sql, self.name, self.type, self.db)
    #@id = DB[:conn].execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  def self.find(id, db) #find pokemon by id AND RETURN a NEW pokemon object
    poke = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten 
    Pokemon.new(id: poke[0] , name: poke[1], type: poke[2], db: db)
     



  end 

end 
