# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

ENV['STABENFELDT_AWS_ACCESS_KEY_ID'] ||= 'test'
ENV['STABENFELDT_SECRET_ACCESS_KEY'] ||= 'test'
ENV['SHORT_NAME'] ||= 'test'

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
