class Log < ActiveRecord::Base
  belongs_to :message
  belongs_to :source
  belongs_to :report
  validates :message_id, :source_id, :report_id, :level_id, :presence => true

  default_scope -> { order('logs.id') }

  LEVELS = { :core => [:debug, :info, :notice, :warning, :err, :alert, :emerg, :crit] }.with_indifferent_access

  def to_s
    "#{source} #{message}"
  end

  def level=(l)
    write_attribute(:level_id, LEVELS[category].index(l))
  end

  def level
    LEVELS[category][level_id]
  end
end
