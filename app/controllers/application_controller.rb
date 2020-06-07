class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @recipes = Recipe.all
    redirect to '/recipes'
  end

  # get '/recipes' is all recipes in @recipes
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end 

  # '/recipes/new' goes to new.erb which creates a new recipe
  get '/recipes/new' do
    erb :new
  end

  # post '/recipes' Creates a new recipe based on 3 params into @recipe
  post '/recipes' do
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  #show
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  #edit
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  #update
  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  #delete
  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params["id"])
    @recipe.destroy
    redirect to "/recipes"
  end

end
