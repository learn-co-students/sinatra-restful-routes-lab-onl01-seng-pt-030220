# class ApplicationController < Sinatra::Base
#   configure do
#     set :public_folder, 'public'
#     set :views, 'app/views'
#   end
#
#   # code actions here!
#     # get '/' do
#     #   erb :index
#     # end
#     get '/recipes' do
#       # binding.pry
#       @recipes = Recipe.all
#       erb :index
#     end
#
#     #display all the recipes
#     get '/recipes/new' do
#       # binding.pry
#       # @recipes = Recipe.all
#       # erb :index
#       erb :new
#     end
#
#     #create new recipe
#     post '/recipes' do
#       # Recipe.create(name: params[:name],
#       #            ingredients: params[:ingredients],
#       #             cook_time: params[:cook_time])
#       #OR you can do the following:
#       @new_receipe = Recipe.new(name: params[:name],
#                  ingredients: params[:ingredients],
#                   cook_time: params[:cook_time])
#       @new_receipe.save
#       redirect to "/recipes/#{@new_receipe.id}"
#       # redirect '/recipes'
#       # binding.pry # >params # => {"name"=>"Name", "ingredients"=>"food", "cook_time"=>"time"}
#     end
#
#     #show
#     get '/recipes/:id' do
#       @item = Recipe.find_by(params[:id])
#       # binding.pry #> params => {"id"=>"1"}
#       erb :show
#     end
#
#     get '/recipes/:id/edit' do
#       @item = Recipe.find_by(params[:id])
#       # binding.pry
#       #> params => {"id"=>"6"}
#       erb :edit
#     end
#
#     patch '/recipes/:id' do #edit action
#         @recipe = Recipe.find_by_id(params[:id])
#         @recipe.name = params[:name]
#         @recipe.ingredients = params[:ingredients]
#         @recipe.cook_time = params[:cook_time]
#         @recipe.save
#         redirect to "/recipes/#{@recipe.id}"
#     end
#
#     delete '/recipes/:id' do #destroy action
#     @recipe = Recipe.find_by_id(params[:id])
#     @recipe.delete
#     redirect to '/recipes'
#   end
#
#
# end



class ApplicationController < Sinatra::Base
  # register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do #loads new form
    erb :new
  end

  get '/recipes' do #loads index page
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do  #loads show page
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do #loads edit form
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do  #updates a recipe
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  post '/recipes' do  #creates a recipe
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do #destroy action
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end
end
