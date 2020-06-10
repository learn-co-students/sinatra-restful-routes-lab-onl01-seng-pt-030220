class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get "/recipes" do
    require 'pry'
    @recipes = Recipe.all
    erb :index
  end

  get "/recipes/new" do
    erb :new
  end


  get "/recipes/:id" do
    @recipe = Recipe.find_by(id: params[:id])
    erb :show
  end

  delete "/recipes/:id" do
    Recipe.find_by(id: params[:id]).delete
    redirect to '/recipes'
  end

  patch "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.cook_time = params[:cook_time]
    @recipe.instructions = params[:instructions]
    redirect to "/recipes/#{@recipe.id}"
  end

  
  post "/recipes"  do
    @new_recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect to "/recipes/#{@new_recipe.id}"
    #erb :show
  end

  get "/recipes/:id/edit" do 
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  

end
