require 'mail'
Mail.defaults do
  delivery_method :smtp, {
                            :address => "smtp.sendgrid.net",
                            :port => '25',
                            :domain => "katalyst.com.au",
                            :authentication => :plain,
                            :user_name => "jason@katalyst.com.au",
                            :password => "i9XypcTh2GOptAvK"
                          }
end

class Asana
  class Error < RuntimeError
  end

  def self.run(argv)
    if argv.empty?
      puts "Please add your task"
    else
      argv.join(' ')
    end
  rescue Error
    $stderr.puts "#$!"
    exit 1
  rescue Interrupt
    $stderr.puts "Interrupted!"
    exit 130
  end

  def initialize(task)
    add_task(task)
  end

  def add_task(task=nil)
    mail = Mail.deliver do
      to ' x@mail.asana.com'
      from 'Rahul Trikha <rahul.trikha@gmail.com>'
      subject 'Test task'
      text_part do
        body 'Notes go here'
      end
    end
  end

  def reconfigure
    token = authenticate['token']
    File.open(self.class.config_file,'w') do |f|
      f.puts "auth_token: #{token}"
    end
  end

  def self.config_file
    File.expand_path('~/.asana.yml')
  end

  def account(auth_token = nil)
    require 'yaml'
    @account ||=
      begin
        reconfigure unless File.exist?(self.class.config_file)
        t = YAML.load(File.read(self.class.config_file))['auth_token']
        account(t)
      end
  end
end
