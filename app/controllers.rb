Buildathing::App.controllers do
  layout :main

  get :index do
    @thing = Thing.get Time.now
    render 'index'
  end
end
