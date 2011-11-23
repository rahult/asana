require 'yaml'
require 'mail'

class Asana
  class Error < RuntimeError
  end

  def initialize(output=STDOUT, argv=nil)
    @output = output
    parse(argv)
  end

  def parse(argv)
    if argv.empty?
      @output.puts "Please provide a task"
      exit
    else
      setup
      @@task = argv.is_a?(Array) ? argv.join("") : argv
    end
  end

  def setup
    @@settings ||= YAML.load(File.read(File.expand_path('~/.asana.yml')))
    Mail.defaults do
      delivery_method :smtp, @@settings[:smtp]
    end
  end

  def message
    Mail.new do
      to @@settings[:to]
      from @@settings[:from]
      subject @@task
    end
  end

  def deliver!
    result = "Unable to add task to Asana"
    if message.deliver
      result = "#{@@task} task added to Asana"
    end
    @output.puts result
  end
end
