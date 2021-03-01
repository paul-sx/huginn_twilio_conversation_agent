require 'rails_helper'
require 'huginn_agent/spec_helper'

describe Agents::TwilioConversationAgent do
  before(:each) do
    @valid_options = Agents::TwilioConversationAgent.new.default_options
    @checker = Agents::TwilioConversationAgent.new(:name => "TwilioConversationAgent", :options => @valid_options)
    @checker.user = users(:bob)
    @checker.save!
  end

  pending "add specs here"
end
