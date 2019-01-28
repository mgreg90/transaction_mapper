class Transaction
  UNMAPPED = 'UNMAPPED_TXN'
  attr_reader :type, :date, :amount, :label, :topic

  def initialize(type:, date:, amount:, label:, mappings: [], topic: UNMAPPED)
    @type = type
    @date = date
    @amount = amount
    @label = label
    @topic = find_topic(mappings) || UNMAPPED
  end

  def unmapped?
    topic == UNMAPPED
  end

  def mapped?
    !unmapped?
  end

  def to_csv_str
    [date, label.gsub(',', ''), amount, topic].join(',')
  end

  private

  def find_topic(mappings)
    @topic = begin
      matched_arr = mappings.find do |name, matchers|
        !!matchers.find do |matcher|
          matcher = /#{matcher}/i
          matcher.match?(label)
        end
      end
      matched_arr[0] if matched_arr
    end
  end
end