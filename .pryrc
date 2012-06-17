# My pry is polite
Pry.config.hooks.add_hook(:after_session, :say_bye) do
  puts "Bye-bye!"
end

Pry.config.hooks.add_hook(:before_session, :say_hello) do
  puts "Welcome, Antiarchitect!"
end

# Prompt with ruby version
Pry.prompt = [proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]

require 'hirb'

# loading rails configuration if it is running as a rails console
railsrc = File.dirname(__FILE__) + '/.railsrc'
load railsrc if File.exists?(railsrc) && defined?(Rails) && Rails.env 