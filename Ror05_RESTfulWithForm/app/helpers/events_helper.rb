module EventsHelper
  def category_options
    Category.all.map{ |c| [c.name, c.id] }
  end
  
  def setup_event(event)
    event.build_location unless event.location
    event
  end
end
