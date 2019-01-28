class TransactionData
  AMEX = :amex
  SIMPLE = :simple

  AMEX_DATE_FORMAT = "%m/%d/%Y".freeze

  attr_reader :file, :mappings, :type, :raw_data

  def initialize(file:, mappings:, type: AMEX)
    @file = file
    @mappings = mappings
    @type = type
    @raw_data = File.read(file)
  end

  def mapped_transactions
    parsed_transaction_data
  end

  private

  def parsed_transaction_data
    contents = File.read(file)
    results = CSV.parse(contents).map do |line|
      next if line.none?
      case type
      when AMEX
        Transaction.new(
          type: AMEX,
          date: Date.strptime(line[0], AMEX_DATE_FORMAT),
          amount: line[2].to_f,
          label: line[3],
          mappings: mappings
        )
      end
    end.compact
  end

end