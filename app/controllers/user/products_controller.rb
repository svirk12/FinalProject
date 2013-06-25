class User::ProductsController < User::BaseController
  before_filter :authenticate_user!
  before_filter :is_product_exist?, :except => [:index, :new, :create]
  
  def index
    @products = current_user.products
  end

  def show
    @product = current_user.products.where(:id => params[:id]).first
  end

  def new
    @product = current_user.products.new
  end

  def edit
    @product = current_user.products.where(:id => params[:id]).first
  end

  def create
    @product = current_user.products.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { 
          redirect_to user_products_path, 
          notice: 'Product was successfully created.' 
        }
      else
        format.html { 
          render action: "new" 
        }
      end
    end
  end

  def update
    @product = current_user.products.where(:id => params[:id]).first

    respond_to do |format|
      if @product.update_attributes(params[:post])
        format.html { 
          redirect_to user_products_path, 
          notice: 'Product was successfully updated.' 
        }
      else
        format.html { 
          render action: "edit" 
        }
      end
    end
  end

  def destroy
    @product = current_user.products.where(:id => params[:id]).first
    @product.destroy

    respond_to do |format|
      format.html { 
        redirect_to user_products_path, 
        notice: 'Product was successfully deleted.'  
      }
    end
  end
  
  private
  #checking fo post and if post not present it return
  def is_product_exist?
    @product = current_user.products.where(:id => params[:id]).first
    unless @product.present?
      redirect_to user_products_path, 
      notice: 'You dont have access to requested product'
    end
  end
  
end
