class TransactionCsvBuilder

  attr_reader :transactions

  def self.call(transactions)
    new(transactions).call
  end

  def initialize(transactions)
    @transactions = transactions
  end

  def call
    FileUtils.touch(file)
    File.open(file, 'w+') do |f|
      f.write headers
      f.write transactions_string
    end
    file
  end

  private

  def file
    PUBLIC_DIR.join('mapped_txns', file_name)
  end

  def file_name
    "transactions_#{first_date}--#{last_date}.csv"
  end

  def sorted_transactions
    @sorted_transactions ||= transactions.sort do |txn1, txn2|
      txn1.date <=> txn2.date
    end
  end

  def first_date
    sorted_transactions.first.date
  end

  def last_date
    sorted_transactions.last.date
  end

  def headers
    "Date,Amount,Label,Category\n"
  end

  def transactions_string
    sorted_transactions.map(&:to_csv_str).join("\n")
  end

end