ServerSpec Extensions
=====

Usage
-----
An extension to serverspec supervisor resources.
adds the ability to dump log lines if a specifed supervisor service is not running.

```ruby
require 'spec_helper'
require 'serverspec_extensions'


describe 'cookbook-my-cookbook::default' do

  logs = [
    '/var/log/supervisor/my-app_stderr.log',
    '/var/log/supervisor/my-app_stdout.log'
  ]

  num_lines = 60

  describe service('my-app') do
    it { should be_running_with_log.under("supervisor_log",logs, num_lines) }
  end

end
```

Install
-----
```bash
gem install serverspec_extensions
```

Build
-----
```bash
gem build serverspec_extensions.gemspec
```
