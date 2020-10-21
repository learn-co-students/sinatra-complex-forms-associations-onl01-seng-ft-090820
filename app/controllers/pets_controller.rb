class PetsController < ApplicationController

#index
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

# create
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    # binding.pry
    if !params[:owner][:name].empty?
      owner = Owner.create(params[:owner])
      @pet.owner_id = owner.id
      # binding.pry
      @pet.save
    
    end
    redirect to "pets/#{@pet.id}"
  end

# show
  get '/pets/:id' do
    #  binding.pry
    @pet = Pet.find_by(id: params[:id])
    erb :'/pets/show'
  end

# edit
  get '/pets/:id/edit' do
    @pet = Pet.find_by(id: params[:id])
    @owners = Owner.all
    # binding.pry
    erb :"pets/edit"
  end

  patch '/pets/:id' do 
    @pet = Pet.find_by(id: params[:id])
    @pet.name = params[:pet][:name]
    # binding.pry
    if params[:owner][:name].empty?
      owner = Owner.find_by(id: params[:pet][:owner_id])
      @pet.owner_id = owner.id
    else
      owner = Owner.create(params[:owner])
      @pet.owner_id = owner.id
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end