RSpec::Matchers.define :be_running_with_log do
  match do |subject|
    if subject.class.name == 'Serverspec::Type::Service'
      subject.running_with_log?(@under, @logs, @lines)
    else
      subject.running?
    end
  end

  chain :under do |under, logs, lines|
    @under = under
    @logs = logs
    @lines = lines
  end

end

module Serverspec # rubocop:disable Documentation

  module Type # rubocop:disable Documentation

    class Service < Base # rubocop:disable Documentation

      def running_with_log?(under, logs, lines = 40)
        if under && logs
          check_method = "check_service_is_running_under_#{under}".to_sym
          @runner.send(check_method, @name, logs, lines)
        else
          @runner.check_service_is_running(@name)
        end
      end

    end

  end

end

module Specinfra

  module Command

    class Base

      class Service < Specinfra::Command::Base # rubocop:disable Documentation

        class << self

          def check_is_running_under_supervisor_logs(service, logs, lines = 40)
            s = service
            unless system("supervisorctl status #{escape(s)}|grep RUNNING")
              logs.each do |log|
                puts "log: #{log}"
                system("tail -n #{lines} #{log}")
              end
            end
            "supervisorctl status #{escape(s)} | grep RUNNING"
          end

        end

      end

    end

  end

end
