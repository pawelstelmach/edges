class ContextsController < ApplicationController
  def index
    @page_id = "contexts"
    @contexts = Context.all
  end
  
  def create
    @context = Context.new(params[:context])
    if @context.save
      redirect_to(contexts_path, :notice => 'Kontekst została utworzony.')
    else
      render contexts_path
    end
  end
  
  def edit
    @page_id = "contexts"
    @context = Context.find(params[:id])
  end
  
  def update
    @context = Context.find(params[:id])
    if @context.update_attributes(params[:context])
      flash[:notice] = "Zapisano zmiany w kontekście."
      redirect_to contexts_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @context = Context.find(params[:id])
    @context.destroy
    redirect_to contexts_path
  end

end
