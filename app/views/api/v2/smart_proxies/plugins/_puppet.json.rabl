attribute :environment_stats
node(:hosts) { Host::Managed.where(:puppet_proxy_id => @smart_proxy.id).count }
