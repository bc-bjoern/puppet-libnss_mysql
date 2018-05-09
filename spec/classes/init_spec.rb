require 'spec_helper'
describe 'libnss_mysql' do
  context 'with default values for all parameters' do
    it { should contain_class('libnss_mysql') }
  end
end
