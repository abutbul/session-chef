require 'serverspec'

set :backend, :exec

describe port('80') do
  it { should be_listening }
end

describe command('apachectl -M') do
  its(:stdout) { should contain('wsgi_module')  }
end

describe command('curl -X POST --silent --output /dev/null --write-out "%{http_code}" -F \'username=ad1\' -F \'password=ad1pw\' http://localhost/') do
  its(:stdout) {should contain('302')}
end


# cookbooks we could potentially use to implement our code
# https://supermarket.chef.io/cookbooks/mysql
# https://supermarket.chef.io/cookbooks/apache2
# https://supermarket.chef.io/cookbooks/poise-python
# https://supermarket.chef.io/cookbooks/apt

