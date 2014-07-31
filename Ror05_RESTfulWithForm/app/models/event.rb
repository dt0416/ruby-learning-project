class Event < ActiveRecord::Base
  # 一對多
  # 案例一: 設計一個 event has_many :attendees
  has_many :attendees # 複數
  
  # 案例二: 讓 event 可以用 select 單選一個 category
  belongs_to :category
  delegate :name, :to => :category, :prefix => true, :allow_nil => true
  
  # 一對一
  # 案例一：建立Location表單
  has_one :location # 單數
  # 案例二：用 Nested Model 順帶編輯跟新增
  accepts_nested_attributes_for :location, :allow_destroy => true, :reject_if => :all_blank
  
  # 多對多 Resources
  # 案例一： 在 event new/edit 中, 可以使用 checkbox 多選 group
  has_many :event_groupships
  has_many :groups, :through => :event_groupships
  
  # 操作 Resources 狀態
  # 案例：設計一個 event_states resource, 可以開關 event 狀態
  def closed?
    self.status == "CLOSED"
  end
  
  def open?
    !self.closed?
  end
  
  def open!
    self.status = "OPEN"
    self.save!
  end
  
  def close!
    self.status = "CLOSED"
    self.save!
  end
end
