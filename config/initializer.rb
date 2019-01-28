%w(bundler pathname json csv fileutils).each { |lib| require lib }

Bundler.require(:default)

ROOT_DIR = Pathname.new(File.expand_path(__FILE__)).join('..', '..')

Dir[ROOT_DIR.join('app', '*.rb')].each { |file| require file }

MAPPINGS_FILE = ROOT_DIR.join('config', 'mappings.json')

PUBLIC_DIR = ROOT_DIR.join('public')