require 'sinatra'
require 'sqlite3'
require 'awesome_print'
require_relative 'config'

def db
  return @db if @db

  @db = SQLite3::Database.new(DB_PATH)
  @db.results_as_hash = true

  @db
end

get '/' do
  redirect '/fruits'
end

get '/fruits' do
  @fruits = db.execute('
    SELECT products.*, categories.name AS category_name
    FROM products
    LEFT JOIN categories
      ON products.category_id = categories.id
  ')

  @categories = db.execute(
    'SELECT * FROM categories'
  )

  erb :'fruits/index'
end

get '/categories' do
  @categories = db.execute(
    'SELECT * FROM categories'
  )

  erb :'category/index'
end

get '/categories/new' do
  @fruits = db.execute('SELECT * FROM products')
  erb :'category/new'
end

post '/categories' do
  db.execute(
    'INSERT INTO categories (name) VALUES (?)',
    [params[:name]]
  )

  category_id = db.last_insert_row_id

  params[:fruits].to_a.each do |fruit_id|
    db.execute(
      'UPDATE products SET category_id = ? WHERE id = ?',
      [category_id, fruit_id]
    )
  end

  redirect '/categories'
end

get '/categories/:id' do |id|

  @category = db.execute(
    'SELECT * FROM categories WHERE id = ?',
    [id]
  ).first

  @fruits = db.execute(
    'SELECT * FROM products WHERE category_id = ?',
    [id]
  )

  erb :'category/show'
end

get '/fruits/new' do

  @categories = db.execute(
    'SELECT * FROM categories'
  )

  erb :'fruits/new'
end


post '/fruits' do

  name = params['fruit_name']
  description = params['fruit_description']
  tastiness = params['fruit_tastiness']
  country = params['fruit_country']
  category_id = params['category_id']

  db.execute(
    'INSERT INTO products
     (name, tastiness, description, country, category_id)
     VALUES (?, ?, ?, ?, ?)',
    [
      name,
      tastiness,
      description,
      country,
      category_id
    ]
  )

  redirect '/fruits'
end

get '/fruits/:id' do |id|

  @fruit = db.execute(
    'SELECT products.*, categories.name AS category_name
     FROM products
     LEFT JOIN categories
       ON products.category_id = categories.id
     WHERE products.id = ?',
    [id]
  ).first

  erb :'fruits/show'
end

get '/fruits/:id/edit' do |id|

  @fruit = db.execute(
    'SELECT * FROM products WHERE id = ?',
    [id]
  ).first

  @categories = db.execute(
    'SELECT * FROM categories'
  )

  erb :'fruits/edit'
end

post '/fruits/:id/update' do |id|

  name = params['fruit_name']
  description = params['fruit_description']
  tastiness = params['fruit_tastiness']
  country = params['fruit_country']
  category_id = params['category_id']

  db.execute(
    'UPDATE products
     SET name = ?,
         tastiness = ?,
         description = ?,
         country = ?,
         category_id = ?
     WHERE id = ?',
    [
      name,
      tastiness,
      description,
      country,
      category_id,
      id
    ]
  )

  redirect '/fruits'
end

post '/fruits/:id/delete' do |id|

  db.execute(
    'DELETE FROM products WHERE id = ?',
    [id]
  )

  redirect '/fruits'
end