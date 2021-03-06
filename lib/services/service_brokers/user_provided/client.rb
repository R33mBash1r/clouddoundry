module VCAP::Services
  class ServiceBrokers::UserProvided::Client
    def provision(_); end

    def bind(binding, _arbitrary_parameters, _accepts_incomplete=nil)
      if binding.class.name.demodulize == 'RouteBinding'
        {
          async: false,
          binding: {
            route_service_url: binding.service_instance.route_service_url,
          }
        }
      else
        {
          async: false,
          binding: {
            credentials: binding.service_instance.credentials,
            syslog_drain_url: binding.service_instance.syslog_drain_url,
          }
        }
      end
    end

    def unbind(*); end

    def deprovision(_, _={})
      {
        last_operation: {
          state: 'succeeded'
        }
      }
    end
  end
end
