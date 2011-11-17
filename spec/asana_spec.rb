require File.expand_path(File.dirname(__FILE__) + '/../spec/spec_helper')

describe Asana do
  subject do
    Asana.new('This is a test task')
  end
end
