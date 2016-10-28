class SectionsController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_page
  before_action :set_section_count, :only => [:edit, :update, :new, :create]

    
  def index
    @sections = @page.sections.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new(:page_id => @page.id)
  end

  def create
    # Instantiate a new object using form parameters
    @section = Section.new(section_params)
    @section.page = @page
    # Save the object
    if @section.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "Section created successfully"
      redirect_to(sections_path(:page_id => @page.id))
    else
      # If save fails, redisplay the form to fix problems
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])    
  end

  def update
    # Find a new object using form parameters
    @section = Section.find(params[:id])
    # Update the object
    flash[:notice] = "Section updated successfully"
    if @section.update_attributes(section_params)
      # If update succeeds, redirect to the show action
      redirect_to(section_path(@section, :page_id => @page.id))
    else
      # If save fails, redisplay the form to fix problems      
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Section deleted successfully"
    redirect_to(sections_path(:page_id => @page.id))
  end

  private 

    def section_params
      params.require(:section).permit(:name, :position, 
                                      :visible, :content_type, :content)
    end

    def find_page
      @page = Page.find(params[:page_id])
    end

    def set_section_count
      @section_count = @page.sections.count
      if params[:action] == 'new' || params[:action] == 'create'
        @section_count += 1
      end
    end
end
