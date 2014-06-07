class HomeController < ApplicationController
  def index
  end
  def fail
    @response = params
  end

  def success
    @response = params
  end

end
