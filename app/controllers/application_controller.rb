class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/recipes" do
    @recipe = Recipe.all
  erb :index
  end

  get "/recipes/:id/edit" do
  @recipe = Recipe.find(params[:id])
  erb :edit
  end

  patch "/recipes/:id/edit" do
  @recipe = Recipe.find(params[:id])
  @recipe.name = params[:name]
  @recipe.ingredients = params[:ingredients]
  @recipe.cook_time = params[:cook_time]
  @recipe.save
  redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/new' do
  erb :new
  end

  post "/recipes" do
  @recipe = Recipe.new(params)
  @recipe.save
  redirect "/recipes/#{@recipe.id}"
  end

  get "/recipes/:id" do
  @recipe = Recipe.find(params[:id])
  erb :show
  end

  delete '/recipes/:id' do
  @delete = Recipe.find(params[:id])
  @delete.delete
  redirect "/recipes"
  end



end
