class EventsController < ApplicationController
  # 使用 before_filter
  before_filter :find_event, :only => [ :show, :edit, :update, :destroy]

  def index
    # 無分頁
    # @events = Event.all
    # 分頁
    @events = Event.page(params[:page]).per(5)
    
    # 使用respond_to產生XML、JSON、Atom
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events.to_xml }
      format.json { render :json => @events.to_json }
      format.atom { @feed_title = "My event list" } # index.atom.builder
    end
  end
  
  def new
    @event = Event.new
  end

  def create
    # @event = Event.new(params[:event]) # 會出錯
    # 改成4.0以上的用法
    @event = Event.new(params.require(:event).permit(:name, :description))
    # @event.save

    # redirect_to :action => :index
    
    # 加入資料驗證
    if @event.save
      # flash
      flash[:notice] = "event was successfully add"
      # redirect_to :action => :index
      # 由上句改成RESTful版本
      redirect_to events_url
    else
      render :action => :new
    end
  end
  
  def show
    # @event = Event.find(params[:id])
    @page_title = @event.name
    
    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }
    end
  end
  
  def edit
    # @event = Event.find(params[:id])
  end
  
  def update
    # @event = Event.find(params[:id])
    # @event.update_attributes(params[:event]) # 會出錯
    # 改成4.0以上的用法
    p = params.require(:event).permit(:name, :description)
    # @event.update_attributes(p)

    # redirect_to :action => :show, :id => @event
    
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
