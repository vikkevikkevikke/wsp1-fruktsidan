require 'sqlite3'
require_relative '../config'

db = SQLite3::Database.new(DB_PATH)

puts "🧹 Tar bort gamla tabeller..."
db.execute('DROP TABLE IF EXISTS products')

puts "🧱 Skapar tabeller..."
db.execute('CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            tastiness INTEGER,
            description TEXT,
            price INTEGER)')

puts "🍎 Fyller på med data..."
db.execute('INSERT INTO products (name, tastiness, description, price) VALUES ("Äpple",  7, "En rund frukt med söt eller syrlig smak. Har sitt ursprung i Kazakstan.", "49kr")')
db.execute('INSERT INTO products (name, tastiness, description, price) VALUES ("Päron",  6, "En saftig frukt med mild och söt smak. Har sitt ursprung i Kina.", "65kr")')
db.execute('INSERT INTO products (name, tastiness, description, price) VALUES ("Banan",  4, "En avlång frukt med mjukt och sött fruktkött. Har sitt ursprung i Sydostasien.", "123kr")')
db.execute('INSERT INTO products (name, tastiness, description, price) VALUES ("Mango",  9, "En söt och saftig frukt med stor kärna. Har sitt ursprung i Indien.", "85kr")')
db.execute('INSERT INTO products (name, tastiness, description, price) VALUES ("Apelsin",  8, "En saftig citrusfrukt med frisk och söt smak. Har sitt ursprung i Kina.", "38kr")')

puts "✅ Databasen är seedad!"
