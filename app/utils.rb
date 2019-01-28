module Utils

  def included(base)
    base.extend(ClassMethods)
    base.include(ClassMethods)
  end

  module ClassMethods
    def quit(message)
      puts "Error: #{message}".red
      puts "Exiting...".red
      exit
    end
  end

end