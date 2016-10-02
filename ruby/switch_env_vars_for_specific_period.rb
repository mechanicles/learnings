# Found one good example in Rails code
# https://github.com/rails/rails/blob/master/railties/test/env_helpers.rb.

# If there are two variables which are already set to some standard values in
# our program. But for testing or for some scenarios, we want to handle them in
# a such manner that if one is being is used, another should be to nil (or to
# other value). This can be achieved like this.

class SwitchEnvVarsService
  attr_reader :env

  def initialize(env)
    @env = env # Consider this as ENV variable.
  end

  def with_rails_env(env)
    switch_env "RAILS_ENV", env do
      switch_env "RACK_ENV", nil do
        yield
      end
    end
  end

  def with_rack_env(env)
    switch_env "RACK_ENV", env do
      switch_env "RAILS_ENV", nil do
        yield
      end
    end
  end

  private
    def switch_env(key, value)
      old, @env[key] = @env[key], value
      yield
    ensure
      @env[key] = old
    end
end

service = SwitchEnvVarsService.new({"RAILS_ENV" => "production", "RACK_ENV" => "production"})

puts service.env["RAILS_ENV"]
puts service.env["RACK_ENV"]

service.with_rails_env('development') do
  puts service.env["RAILS_ENV"] # => 'development'
  puts service.env["RACK_ENV"] # => nil
end

puts service.env["RAILS_ENV"]
puts service.env["RACK_ENV"]

service.with_rack_env('test') do
  puts service.env["RAILS_ENV"] # => nil
  puts service.env["RACK_ENV"] # => 'test'
end

puts service.env["RAILS_ENV"]
puts service.env["RACK_ENV"]
