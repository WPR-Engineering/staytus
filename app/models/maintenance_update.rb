# == Schema Information
#
# Table name: maintenance_updates
#
#  id                :integer          not null, primary key
#  maintenance_id    :integer
#  user_id           :integer
#  text              :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  identifier        :string(255)
#  notify            :boolean          default(FALSE)
#  low_risk_email    :boolean
#  medium_risk_email :boolean
#  high_risk_email   :boolean
#

class MaintenanceUpdate < ActiveRecord::Base

  belongs_to :maintenance, :touch => true
  belongs_to :user

  validates :text, :presence => true

  random_string :identifier, :type => :hex, :length => 6, :unique => true

  scope :ordered, -> { order(:id => :desc) }

  after_commit :send_notifications_on_create, :on => :create
  after_commit :send_low_risk_on_create, :on => :create
  after_commit :send_med_risk_on_create, :on => :create
  after_commit :send_high_risk_on_create, :on => :create

  florrick do
    string :text
    string :identifier
    relationship :maintenance
    relationship :user
  end

  def send_notifications
    for subscriber in Subscriber.verified
      Staytus::Email.deliver(subscriber, :new_maintenance_update, :maintenance => self.maintenance, :update => self)
    end
  end

  def send_lists(list)
      Staytus::Email.deliverlist(list, :new_maintenance_update, :maintenance => self.maintenance, :update => self)
  end

  def send_notifications_on_create
    if self.notify?
      self.delay.send_notifications
    end
  end

  def send_low_risk_on_create
    if self.low_risk_email?
      self.delay.send_lists(CONFIG[:MAINT_LIST][:LOW_RISK_LIST])
    end
  end

  def send_med_risk_on_create
    if self.medium_risk_email?
      self.delay.send_lists(CONFIG[:MAINT_LIST][:LOW_RISK_LIST])
    end
  end

  def send_high_risk_on_create
    if self.high_risk_email?
      self.delay.send_lists(CONFIG[:MAINT_LIST][:LOW_RISK_LIST])
    end
  end


end
