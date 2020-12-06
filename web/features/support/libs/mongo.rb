require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB
  attr_accessor :mongoDB, :users, :equipos

  def initialize
    @mongoDB = Mongo::Client.new(CONFIG["mongo"])

    @users = mongoDB[:users]
    @equipos = mongoDB[:equipos]
  end

  def drop_danger
    @mongoDB.database.drop
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def get_user(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  def remove_equipo(name, email)
    user_id = get_user(email)
    @equipos.delete_many({ name: name, user: user_id })
  end
end
