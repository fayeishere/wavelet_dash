require "./lib/graphite"
require 'URI'

# last started parkingsessions
SCHEDULER.every '30s', :first_in => 0 do
  # Create an instance of our helper class
  q = Graphite.new URI::Generic.build(:scheme => 'http',
                                      :host   => 'localhost',
                                      :port   => 9999,
                                      :path   => '/graphite')

  graphite_test_target = 'graphite.com.crowdcompass.vagrant.graphite.cpu.0.idle'
  
  # get the current value
  current = q.value(graphite_test_target, '-1min')
  # get points for the last half hour
  # points = q.points(graphite_test_target, "-30min")
  
  # send to dashboard, so the number the meter and the graph widget
  # can understand it
  send_event('graphite_test', { current: current })
end
