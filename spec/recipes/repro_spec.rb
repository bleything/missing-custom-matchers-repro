require 'chefspec'

describe 'failure' do
  subject { ChefSpec::SoloRunner.new.converge 'repro' }

  it { should do_something 'useful' }
end

describe 'success' do
  subject { ChefSpec::SoloRunner.new.converge 'repro' }

  it { should include_recipe 'repro::helper' }
  it { should do_something 'useful' }
end

