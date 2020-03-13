# encoding: utf-8
# author: Mesaguy

describe file('/opt/prometheus/scripts/deleted_libraries.py') do
    it { should be_file }
    it { should be_executable }
    its('content') { should match /description = 'Count of running processes that link a deleted library'/ }
    its('size') { should > 600 }
    its('mode') { should cmp '0555' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end
