class HomeController < ApplicationController
  def index
    @message = "Welcome to Dollhouse Blog!"
    @description = "A simple markdown-based blog built with Ruby on Rails"
  end
end