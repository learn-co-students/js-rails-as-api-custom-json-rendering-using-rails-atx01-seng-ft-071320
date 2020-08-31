class BirdsController < ApplicationController
  def index
    birds = Bird.all
    render json: birds, only: [:id, :name, :species]#only: filters out the data we want to render
    # render json: birds, except: [:created_at, :updated_at]# does the same as the code above
  end

  def show
    # As nil is a false-y value in Ruby, this gives us the ability to write our own error messaging in the event that a request is made for a record that doesn't exist:
    bird = Bird.find_by(id: params[:id])
    if bird
    # the two methods below allows us to remove pieces of info we don't care to send, in this case data like: created_at and updated_at.
    # render json: {id: bird.id, name: bird.name, species: bird.species }
    render json: bird.slice(:id, :name, :species) #does same as code above/ however doesn't work on array of hashes(only single hashes)
    else 
      render json: { message: 'Bird not found' }
    end
  end

end


# Drawing Back the Curtain on Rendering JSON Data
# As we touched upon briefly in the previous lesson, the controller actions we have seen so far have a bit of Rails 'magic' in them that obscures what is actually happening in the render statements. The only and except keywords are actually parameters of the to_json method, obscured by that magic. The last code snippet can be rewritten in full to show what is actually happening:

# def index
#   birds = Bird.all
#   render json: birds.to_json(except: [:created_at, :updated_at])
# end