require File.expand_path(File.dirname(__FILE__) + '/../spec/spec_helper')

describe Asana do
  let(:output) { double('output').as_null_object }

  subject do
    Asana.new(output, "Test")
  end

  it "it should exit cleanly if no task is provided" do
    lambda { ::Asana.new(output, "") }.should raise_error SystemExit
  end

  it "should return a Mail object" do
    subject.message.class.eql?(Mail::Message)
  end

  it "should return a success message after delivering a task" do
    subject.deliver!.eql?("Test task added to Asana")
  end
end
