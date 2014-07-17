class Event < ActiveRecord::Base
    validates_presence_of :name # 必填
end
