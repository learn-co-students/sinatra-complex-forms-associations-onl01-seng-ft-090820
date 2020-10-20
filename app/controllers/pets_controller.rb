class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    # binding.pry
    erb :'/pets/new'
  end

  post '/pets' do 
    binding.pry
    @pet = Pet.create(params[:pet])
    @pet.owner = Owner.find(params[:pet][:owner_id][0])
    if !params["owner"]["name"].empty? 
      @pet.owner = Owner.create(name: params["owner"]["name"])
    redirect to "pets/#{@pet.id}"
    end
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
     @pet.owner = Owner.create(name: params["owner"]["name"])
    end 
    redirect to "pets/#{@pet.id}"
  end
end

