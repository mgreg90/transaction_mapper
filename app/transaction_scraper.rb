class TransactionScraper

  def self.call
    new.call
  end

  def initialize
  end

  def call
    webdriver.navigate.to "https://www.americanexpress.com/"
    login
    go_to_card_activity
    go_to_transaction_download
    download_transactions
  ensure
    webdriver.quit
  end
  
  private
  
  def login
    type_in value: AMEX_USERNAME, id: 'login-user'
    type_in value: AMEX_PASSWORD, id: 'login-password'

    click id: 'login-submit'
  end
  
  def go_to_card_activity
    wait_then_click link_text: 'View All Activity'
  end
  
  def go_to_transaction_download
    wait_then_click class: 'toolbar-button-download'
    wait_then_click id: 'blindCardActivity'
    wait_then_click id: 'nav_6'
  end

  def download_transactions
    webdriver.find_elements(class: 'modifiedIcon').each do |checkbox|
      begin
        checkbox.click
      rescue Selenium::WebDriver::Error::ElementNotVisibleError
      end
    end

    click id: 'downloadFormButton'
    binding.pry
  end

  def webdriver
    @webdriver ||= Selenium::WebDriver.for :chrome, options: webdriver_options
  end

  def webdriver_options
    download_preferences = {
      prompt_for_download: false, 
      default_directory: PUBLIC_DIR.join('raw_txns')
    }

    options = Selenium::WebDriver::Chrome::Options.new
    # options.add_argument '--headless'
    options.add_preference :download, download_preferences

    options
  end

  def wait_then_click(timeout: 10, **args)
    wait = Selenium::WebDriver::Wait.new(timeout: timeout)
    wait.until { webdriver.find_element(**args) }
    click(**args)
  end

  def click(**args)
    element = webdriver.find_element(**args)
    element.click
  end

  def type_in(value:, **args)
    username_element = webdriver.find_element(**args)
    username_element.send_keys value
  end
end