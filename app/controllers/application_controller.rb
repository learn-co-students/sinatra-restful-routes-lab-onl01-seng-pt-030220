class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end


  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
  erb :edit
  end

  post '/recipes' do
    recipe = Recipe.new(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    recipe.save
    redirect "/recipes/#{recipe.id}"
  end

  patch '/recipes/:id' do
   @recipe = Recipe.find_by_id(params[:id])
    puts "TEEEEEEEEST"
    puts recipe
    @recipe.update(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect "/recipes/#{recipe.id}"
  end


  delete '/recipes/:id' do
   Recipe.find_by_id(params[:id]).delete
    redirect "/recipes"
  end
end
