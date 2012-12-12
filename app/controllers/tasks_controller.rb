class TasksController < ApplicationController
  
  before_filter :authenticate_user!

  # GET /tasks/1/kanban
  def kanban
    @coll_01 = Task.where(:Sprint_id => params[:id], :column => 1)
    @coll_02 = Task.where(:Sprint_id => params[:id], :column => 2)
    @coll_03 = Task.where(:Sprint_id => params[:id], :column => 3)
    @coll_04 = Task.where(:Sprint_id => params[:id], :column => 4)
  end

  # AJAX /tasks/sort
  def sort
    
    #@books = Book.all
    #@books.each do |book|
    #  book.position = params['book'].index(book.id.to_s) + 1
    #  book.save
    #end
    debug(params)

    render :nothing => true
  end  

  # GET /tasks/new
  def new
    @task       = Task.new
    @sprint_id  = params[:id] 
  end

  # GET /tasks/1/edit
  def edit
    @task       = Task.find(params[:id])
    @sprint_id  = @task.Sprint_id
  end

  # POST /tasks
  def create
    @task = Task.new(params[:task])

    if @task.save
      redirect_to :action=>'kanban', :id=>params[:task][:Sprint_id]
    else
      render :action => "new" 
    end
  end

  # PUT /tasks/1
  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      redirect_to :action=>'kanban', :id=>params[:task][:Sprint_id]
    else
      render :action => "edit"
    end
  end

  # DELETE /tasks/1
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to :back
  end

end
