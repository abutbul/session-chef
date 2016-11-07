#TODO how do I call attributes from here,,,
#TODO how can i avoid repeating defining sqlpopulate
require 'chefspec'

describe 'my-first-cookbook::default' do

    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }
    
    it 'creates apache config template with a VirtualHost definition' do
      expect(chef_run).to create_template('/etc/apache2/sites-enabled/AAR-apache.conf')
      expect(chef_run).to render_file('/etc/apache2/sites-enabled/AAR-apache.conf').with_content {|content|
        expect(content).to include('<VirtualHost *:80>')
        expect(content).to include('</VirtualHost>')
      }
    end

    it 'restarts apache2 service on config file change' do
      filechanged = chef_run.template('/etc/apache2/sites-enabled/AAR-apache.conf')
      expect(filechanged).to notify('service[apache2]').to(:restart).immediately
    end

    it 'starts and enables apache2 service' do
      expect(chef_run).to start_service('apache2')
      expect(chef_run).to enable_service('apache2')
    end

    it 'populates DB on dump deployment' do
      sqlpopulate = chef_run.cookbook_file('/tmp/make_AARdb.sql')
      expect(sqlpopulate).to notify('execute[makeAARdb]').to(:run).immediately
    end

    it 'creates and grants permissions to app db user' do
      sqlpopulate = chef_run.cookbook_file('/tmp/make_AARdb.sql')
      expect(sqlpopulate).to notify('execute[CREATE USER]').to(:run).immediately
    end
end
