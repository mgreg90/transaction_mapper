require_relative "./config/initializer.rb"

class TransactionMapper
  include Utils

  attr_reader :csv_data, :mappings

  def self.call(args)
    new(args).call
  end

  def initialize(args)
    validate(args)
    csv_file_arg = args.first
    @mappings = JSON.parse(File.read(MAPPINGS_FILE))
    @csv_data = TransactionData.new(
      file: csv_file_arg,
      mappings: mappings
      )
  end

  def call
    mapped_transactions = map_transactions
    display_unmapped_labels(mapped_transactions)
    # TODO write new csv
  end

  private

  def validate(args)
    csv_file_arg = args.first
    quit "No csv given!" if !csv_file_arg
    quit "Csv file doesn't exist!" if !File.exist?(csv_file_arg)
  end

  def map_transactions
    csv_data.mapped_transactions
  end

  def display_unmapped_labels(transactions)
    unmapped_txns = transactions.select { |txn| txn.unmapped? }
    return if unmapped_txns.none?

    puts "Unmapped transaction labels:\n".white
    unmapped_txns.each do |txn|
      message = "#{txn.label.downcase}\t#{txn.date} : $#{txn.amount}"
      puts message.white
    end

    total = transactions.select { |txn| txn.unmapped? }.count
    puts "\ntotal unmapped: #{total}".white
  end

end