Buildathing::App.controllers do
  layout :main

  get :index do
    @thing = Thing.get Time.now
    if @thing.nil?
      @thing = Thing.latest
    end

    render 'index'
  end
end
