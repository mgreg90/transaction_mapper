require 'bundler'
require 'pathname'
require 'json'
require 'csv'
Bundler.require(:default)

ROOT_DIR = Pathname.new(File.expand_path(__FILE__)).join('..', '..')

Dir[ROOT_DIR.join('app', '*.rb')].each { |file| require file }

MAPPINGS_FILE = ROOT_DIR.join('config', 'mappings.json')