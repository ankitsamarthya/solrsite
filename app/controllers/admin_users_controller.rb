class AdminUsersController < ApplicationController
  
  layout 'admin'

  
  before_action :confirm_logged_in


  def index

    if params[:admin_sort].nil? 
      @admin_users = AdminUser.sorted_by_id
      @admin_sort = '1'
    else
        if params[:admin_sort][:sort_type]=='1'
          @admin_users = AdminUser.sorted_by_id
          @admin_sort = '1'
        else 
          if params[:admin_sort][:sort_type]=='2'
            @admin_users = AdminUser.sorted_first_name
            @admin_sort = '2'
          else
            @admin_users = AdminUser.sorted_last_name
            @admin_sort = '3'
          end
        end
    end
  end
    

  def new
    @admin_user =AdminUser.new()
  end

  def create
    @admin_user =AdminUser.new(admin_user_params)
    if @admin_user.save
      flash[:notice] = 'Admin User Created Succesfully.'
      redirect_to(:action => 'index')
    else
      render(:action => 'new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])

  end

  def update
     @admin_user = AdminUser.find(params[:id])
     if @admin_user.update_attributes(admin_user_params)
      flash[:notice] = "Admin User updated Succesfully."
      redirect_to(:action => 'show', :id => @admin_user.id)
     else
      # update fails display the form again
      render('edit')
      end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])

  end

  def destroy
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.destroy()
      flash[:notice] = "Admin User deleted Succesfully."
      redirect_to(:action => 'index')
    else
      render('delete')
    end
    
  end

  def show
    @admin_user = AdminUser.find(params[:id])
    # if AdminUser.find(params[:id])
    #   render(:action => 'show')
    # else
    #   flash[:notice] = "User Not found"
    #   redirect_to('index')
    # end
  end

  private
    def admin_user_params
      # same as using "params[:subject]", except that it :
      # -r mass-assignedaises an error if :subject is not present
      # -allows listed attributes to be
      params.require(:admin_user).permit(:first_name,:last_name, :email, :username,:password,:password_confirmation) 
    end

end
