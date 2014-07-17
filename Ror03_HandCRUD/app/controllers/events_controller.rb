class EventsController < ApplicationController
  # 使用 before_filter
  before_filter :find_event, :only => [ :show, :edit, :update, :destroy]

  def index
    # 無分頁
    # @events = Event.all
    # 分頁
    @events = Event.page(params[:page]).per(5)
  end
  
  def new
    @event = Event.new
  end

  def create
    # @event = Event.new(params[:event]) # 會出錯
    # 改成4.0以上的用法
    @event = Event.new(params[:event].permit(:name, :description))
    # @event.save

    # redirect_to :action => :index
    
    # 加入資料驗證
    if @event.save
      # flash
      flash[:notice] = "event was successfully add"
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
  
  def show
    # @event = Event.find(params[:id])
    @page_title = @event.name
  end
  
  def edit
    # @event = Event.find(params[:id])
  end
  
  def update
    # @event = Event.find(params[:id])
    # @event.update_attributes(params[:event]) # 會出錯
    # 改成4.0以上的用法
    p = params[:event].permit(:name, :description)
    # @event.update_attributes(p)

    # redirect_to :action => :show, :id => @event
    
    # 加入資料驗證
    if @event.update_attributes(p)
      redirect_to :action => :show, :id => @event
    else
      render :action => :edit
    end
  end
  
  def destroy
    # @event = Event.find(params[:id])
    @event.destroy

    flash[:alert] = "event was successfully delete"
    redirect_to :action => :index
  end
  
  protected

  def find_event
    @event = Event.find(params[:id])
  end
end
