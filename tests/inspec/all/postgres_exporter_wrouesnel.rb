# encoding: utf-8
# author: Mesaguy

describe file('/opt/prometheus/exporters/postgres_exporter_wrouesnel/active') do
    it { should be_symlink }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

describe file('/opt/prometheus/exporters/postgres_exporter_wrouesnel/active/postgres_exporter') do
    it { should be_file }
    it { should be_executable }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

# Verify the 'postgres_exporter_wrouesnel' service is running
control '01' do
  impact 1.0
  title 'Verify postgres_exporter_wrouesnel service'
  desc 'Ensures postgres_exporter_wrouesnel service is up and running'
  describe service('postgres_exporter_wrouesnel') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

describe processes('postgres_exporter') do
    it { should exist }
    its('entries.length') { should eq 1 }
    its('users') { should include 'prometheus' }
end

describe port(9187) do
    it { should be_listening }
end

describe http('http://127.0.0.1:9187/metrics') do
    its('status') { should cmp 200 }
end