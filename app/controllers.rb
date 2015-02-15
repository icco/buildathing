Buildathing::App.controllers do
  layout :main

  get :index do
    @thing = Thing.get Time.now
    if @thing.nil?
      @thing = Thing.latest
    end

    render :index
  end

  get :archive do
    @things = Thing.all.sort {|a,b| b <=> a }
    render :archive
  end

  get :about do
    render :about
  end
end
