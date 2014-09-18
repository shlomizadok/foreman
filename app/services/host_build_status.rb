class HostBuildStatus
  attr_reader :host, :state, :errors
  delegate :available_template_kinds, :smart_proxies, :to => :host
  VALIDATION_TYPES = [:host, :templates, :proxies]

  def initialize(host)
    @host   = host
    @errors = {}
    @state  = true # default to true state
    VALIDATION_TYPES.each {|type| @errors[type] = []}
    # host_status
    templates_status
    smart_proxies_status
    state
  end

  private

  def host_status
    return if host.valid?
    host.errors.full_messages.each do |error|
      fail!(:host, error.to_s)
    end
  end
  def templates_status
    fail!(:templates, _('No templates found for this host.')) if available_template_kinds.empty?

    available_template_kinds.each do |template|
      begin
        valid_template = host.unattended_render(template.template)
        fail!(:templates, _('Template %s is empty.') % template.name) if valid_template.blank?
      rescue => exception
        fail!(:templates, (_('Failure parsing %s: %s.') % [template.name, exception]))
        raise exception
      end
    end
  end

  def smart_proxies_status
    fail!(:proxies, _('No smart proxies found.')) if smart_proxies.empty?

    smart_proxies.each do |proxy|
      begin
        errors = proxy.refresh.errors.any?
        fail!(:proxies, _('Failure deploying via smart proxy %s: %s.') % [proxy, errors.to_sentence]) if errors
      rescue => error
        fail!(:proxies, _('Error connecting to %s: %s.') % [proxy, error])
      end
    end

  end

  def fail!(type, msg)
    @state = false
    @errors[type] << msg
  end
end
