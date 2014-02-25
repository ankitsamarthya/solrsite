class AccessController < ApplicationController
  
  layout 'admin'
  skip_before_filter :verify_authenticity_token, :only => [:search]
  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  
  def index
  	# display text & links
  end

  def login
  	# login form
  end

  def attempt_login
	  	if params[:username].present? && params[:password].present?
	  		found_user = AdminUser.where(:username => params[:username]).first
	  			if found_user
	  				
			  		if found_user.authenticate(params[:password])
			  			# mark user as logged in 
			  			session[:user_id] = found_user.id
			  			session[:username] = found_user.username
			  			flash[:notice] = "You are Now logged in."
			  			redirect_to(:action => 'index')
			  			# redirect_to(:action => 'index', :name => found_user.username)
			  		else
			  			flash[:notice] = "invalid username/password combination"
			  			redirect_to(:action => 'login')
			  		end
			  	
			    else
			    	flash[:notice] = "invalid username/password combination"
			  		redirect_to(:action => 'login')
			    end
	  	else
	  		flash[:notice] = "Username/password can't left blank"
	  		redirect_to(:action =>'login')
	  	end

  end

  def logout
  	# marked user as logout
  	session[:user_id] = nil
	session[:username] = nil
  	flash[:notice] = "You are Now logged out."
	redirect_to(:action => 'login')
  end

  	def search

  		@results = Sunspot.search(Subject,Page) do |q|
  			if params[:search].present?
  				q.fulltext params[:search]
  				# q.paginate :page => 1, :per_page => 10
  				# q.keywords params[:search]
  			end
  			if params[:page_from].present? && params[:page_to].present?
	  			q.with(:name,params[:page_from].to_i..params[:page_to].to_i)
	  		end

	  		# if params[:price_from].present? && params[:price_to].present?
	  		# 	q.with(:price,params[:price_from].to_i..params[:price_to].to_i)
	  		# end
	  		# binding.pry

	  		# q.with(:sub_category_id,params[:id].to_i) if params[:from]=="sub_category"
	  		# q.with(:category_id,params[:id].to_i) if params[:from]=="category"
	  	end
	  	render :action => 'index'	
	  	# binding.pry
  	end
end
