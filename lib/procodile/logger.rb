require 'logger'
module Procodile

  def self.mutex
    @mutex ||= Mutex.new
  end

  def self.log(color, name, text)
    mutex.synchronize do
      text.to_s.lines.map(&:chomp).each do |message|
        output  = ""
        output += "#{Time.now.strftime("%H:%M:%S")} #{name.ljust(18, ' ')} | ".color(color)
        begin
          message = message.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
          output += message
        rescue Encoding::UndefinedConversionError => error
          output += "********** ERROR WITH ENCODING (Encoding::UndefinedConversionError) **********"
          output += "#{error}"
          output += "#{error.message}"
        end
        
        $stdout.puts output
        $stdout.flush
      end
    end
  end

end
