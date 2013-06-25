class Public::BlogsController < Public::BaseController
  before_filter :authenticate_user!, :except => [:index, :show, :create]
  before_filter :is_login?, :only => [:create]
  
  #listing of all the post on the admin area side
  def index
    @products = Product.created_at_order
  end
  
  #show all the comments on the public place
  def show
    @product = Product.where(:id => params[:id]).first
    @comment = @product.comments.new
    @comments = @product.comments.created_at_order
  end
  
  #create comments and save into db
  def create    
    @comment = @product.comments.new(params[:comment])
    #@comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.js { 
          flash[:notice] = 'Comment was successfully created.' 
        }
      else
        format.js { 
          flash[:error] = @comment.errors.full_messages.join('<br/>')
        }
      end
    end
    @comments = @product.comments.created_at_order
  end

  def destroy
    @product = Product.where(:id => params[:product_id]).first
    @comment = @product.comments.where(:id => params[:id]).first
    @comment.destroy if @comment.is_owner?(current_user.id)

    respond_to do |format|
      format.js { 
        @comments = @product.comments.created_at_order
        flash[:notice] = 'Comment was successfully deleted'
        render action: :create 
      }
    end  
  end

  private
  
  #check, if user is not login 
  #then check and and visitor not able to create comment
  def is_login?
    @product = Product.where(:id => params[:id]).first
    unless current_user.present?
      respond_to do |format|
        format.js { 
          @comments = @product.comments.created_at_order
          flash[:error] = "You need to sign in or sign up before continuing." 
          render action: :create and return true 
        }
      end
    end
  end 
  
end
