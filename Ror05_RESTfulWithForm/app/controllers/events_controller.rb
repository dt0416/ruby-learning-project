class EventsController < ApplicationController
  # 使用 before_filter
  before_filter :find_event, :only => [ :show, :edit, :update, :destroy]

  def index
    # 分頁
    # @events = Event.page(params[:page]).per(5)

    # 排序 Resources
    sort_by = (params[:order] == 'name') ? 'name' : 'created_at'
    @events = Event.order(sort_by).page(params[:page]).per(5)
  end
  
  def new
    @event = Event.new
    @groups = Group.all
  end

  def create
    # @event = Event.new(params[:event]) # 會出錯
    # 改成4.0以上的用法
    @event = Event.new(params.require(:event).permit(:name, :description, :location))
    
    # 加入資料驗證
    if @event.save
      # flash
      flash[:notice] = "event was successfully add"
      # 由上句改成RESTful版本
      redirect_to events_url
    else
      render :action => :new
    end
  end
  
  def show
    @page_title = @event.name
  end
  
  def edit
    @groups = Group.all
  end
  
  def update
    # @event.update_attributes(params[:event]) # 會出錯
    # 改成4.0以上的用法
    p = params.require(:event).permit(:name, :description)
    
    # 加入資料驗證
    if @event.update_attributes(p)
      # redirect_to :action => :show, :id => @event
      # 由上句改成RESTful版本
      redirect_to event_url(@event)
    else
      render :action => :edit
    end
  end
  
  def destroy
    @event.destroy

    flash[:alert] = "event was successfully delete"
    redirect_to :action => :index
  end
  
  def search
    @events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ]).page(params[:page] ).per(5)
    render :action => :index
  end
  
  def dashboard
    @event = Event.find(params[:id])
  end
  
  protected

  def find_event
    @event = Event.find(params[:id])
  end
end
