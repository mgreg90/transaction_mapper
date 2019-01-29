%w(bundler pathname json csv fileutils dotenv/load).each { |lib| require lib }

Bundler.require(:default)

ROOT_DIR = Pathname.new(File.expand_path(__FILE__)).join('..', '..')
PUBLIC_DIR = ROOT_DIR.join('public')
MAPPINGS_FILE = ROOT_DIR.join('config', 'mappings.json')

Dir[ROOT_DIR.join('app', '*.rb')].each { |file| require file }

AMEX_USERNAME = ENV['AMEX_USERNAME']
AMEX_PASSWORD = ENV['AMEX_PASSWORD']