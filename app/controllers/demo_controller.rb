class DemoController < ApplicationController
  layout 'application'

  def index
  	#render('hello')
  	#or render('demo/hello')
  	#redirect_to(:action =>'other_hello')
  end

  def hello
  	#redirect_to('http://www.google.com')
  	@array=[1,3,4,3,6,3,8]
  	@id=params[:id].to_i
  	@page=params[:page].to_i
  end

  def other_hello
  	render(:text => 'Hello everyone')
  end

  def escape_output
    
  end
end
