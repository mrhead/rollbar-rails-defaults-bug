require "bundler/setup"
require "rails/all"
require "minitest/autorun"

Bundler.require

module BugTestApp
  class App < Rails::Application
    # Rails 6.0 defaults are not loaded yet
    config.eager_load = false
  end
end

Rails.application.initialize!

# this simulates an initializer in config/initializers/new_framework_defaults_6_0.rb
Rails.application.config.active_job.return_false_on_aborted_enqueue = true

class BugTest < Minitest::Test
  def test_return_false_on_aborted_enqueue
    assert ActiveJob::Base.return_false_on_aborted_enqueue, "Expected ActiveJob::Base.return_false_on_aborted_enqueue to be true"
  end
end
