module TestHelpers
  # http://www.programmersparadox.com/2012/03/05/testing-api-integrations-in-rspec/
  def wait(time, increment = 5, elapsed_time = 0, &block)
    begin
      yield
    rescue Exception => e
      if elapsed_time >= time
        raise e
      else
        sleep increment
        wait(time, increment, elapsed_time + increment, &block)
      end
    end
  end
end