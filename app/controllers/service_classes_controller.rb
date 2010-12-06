class ServiceClassesController < ApplicationController
  def index
    @page_id = "classes"
    @service_classes = ServiceClass.all
  end
  
  def create
    @service_class = ServiceClass.new(params[:service_class])
    if @service_class.save
      redirect_to(service_classes_path, :notice => 'Klasa została utworzona.')
    else
      render service_classes_path #check 
    end
  end
  
  def edit
    @page_id = "classes"
    @service_class = ServiceClass.find(params[:id])
  end
  
  def update
    @service_class = ServiceClass.find(params[:id])

      if @service_class.update_attributes(params[:service_class])
        redirect_to(service_classes_path, :notice => 'Klasa została zaktualizowana.')
      else
        render :action => "edit"
      end
  end
  
  def destroy
    @service_class = ServiceClass.find(params[:id])
    @service_class.destroy
    redirect_to(service_classes_url)
  end

end
