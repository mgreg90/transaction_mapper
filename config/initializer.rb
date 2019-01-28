require 'bundler'
Bundler.setup(:default)

require 'pathname'

ROOT_DIR = Pathname.new(File.expand_path('..', __FILE__))
MAPPINGS_FILE = ROOT_DIR.join('config', 'mappings.json')