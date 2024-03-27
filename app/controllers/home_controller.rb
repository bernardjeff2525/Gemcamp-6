class HomeController < ApplicationController

  def index
    @names = ['mark', 'jasper', 'rex', 'jerome']
  end

  def about; end

  def contact_us; end
end