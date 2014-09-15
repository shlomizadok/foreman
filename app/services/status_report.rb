class StatusReport
  attr_accessor :passed, :message, :error
  def initialize(passed, message, error=nil)
    @passed = passed
    @message = message
    @error = error
  end
end
