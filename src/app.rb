require File.expand_path('..', __FILE__)

class TransactionMapper
  def self.call(**args)
    new(**args).call
  end

  def initialize(csv_file:)
    @csv_file = args.first
    @mappings = File.read(MAPPINGS_FILE)
  end

  def call
    binding.pry
  end
end