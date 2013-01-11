require File.dirname(__FILE__) + '/../lib/sensu/base.rb'

describe 'Sensu::Process' do
  before do
    @process = Sensu::Process.new
  end

  it 'can create a pid file' do
    @process.write_pid('/tmp/sensu.pid')
    File.open('/tmp/sensu.pid', 'r').read.should eq(::Process.pid.to_s + "\n")
  end

  it 'can exit if it cannot create a pid file' do
    lambda { @process.write_pid('/sensu.pid') }.should raise_error(SystemExit)
  end

  it 'can adjust eventmachine settings (thread pool size)' do
    EM::threadpool_size.should eq(20)
    @process.setup_eventmachine
    EM::threadpool_size.should eq(14)
  end
end
