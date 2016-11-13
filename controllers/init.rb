# frozen_string_literal: true
require 'sinatra'
require 'econfig'
require 'kktix_api'

require_relative 'base'

Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end
