require 'sqlite3'
require_relative '../config'

db = SQLite3::Database.new(DB_PATH)

puts "🧹 Tar bort gamla tabeller..."

db.execute('DROP TABLE IF EXISTS products')
db.execute('DROP TABLE IF EXISTS categories')

puts "🧱 Skapar tabeller..."

db.execute('
  CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
  )
')

db.execute('
  CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    tastiness INTEGER,
    description TEXT,
    country TEXT,
    category_id INTEGER
  )
')

puts "🍎 Fyller på med data..."

db.execute('
  INSERT INTO categories (name)
  VALUES ("Kärnfrukt")
')

db.execute('
  INSERT INTO categories (name)
  VALUES ("Tropisk frukt")
')

db.execute('
  INSERT INTO categories (name)
  VALUES ("Citrusfrukt")
')

db.execute('
  INSERT INTO products
  (name, tastiness, description, country, category_id)
  VALUES
  (
    "Päron",
    6,
    "En nästan rund, men lite avlång, frukt. Oftast mjukt fruktkött.",
    "Uzbekistan",
    1
  )
')

db.execute('
  INSERT INTO products
  (name, tastiness, description, country, category_id)
  VALUES
  (
    "Äpple",
    7,
    "En rund frukt som finns i många olika färger.",
    "Sverige",
    1
  )
')

db.execute('
  INSERT INTO products
  (name, tastiness, description, country, category_id)
  VALUES
  (
    "Banan",
    4,
    "En avlång gul frukt.",
    "Sydafrika",
    2
  )
')

db.execute('
  INSERT INTO products
  (name, tastiness, description, country, category_id)
  VALUES
  (
    "Mango",
    9,
    "En god frukt med stor kärna.",
    "Pakistan",
    2
  )
')

db.execute('
  INSERT INTO products
  (name, tastiness, description, country, category_id)
  VALUES
  (
    "Kiwi",
    8,
    "En liten grön frukt.",
    "Brasilien",
    2
  )
')

db.execute('
  INSERT INTO products
  (name, tastiness, description, country, category_id)
  VALUES
  (
    "Apelsin",
    7,
    "En rund orange citrusfrukt.",
    "Frankrike",
    3
  )
')

puts "✅ Databasen är seedad!"