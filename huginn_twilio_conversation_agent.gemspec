# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "huginn_twilio_conversation_agent"
  spec.version       = '0.2'
  spec.authors       = ["Paul"]
  spec.email         = ["git@paul.sx"]

  spec.summary       = %q{Agent for Huginn that sends to the Twilio Conversations Endpoint}
  spec.description   = %q{This is an agent for Huginn that allows sending a text message to the conversation endpoint in Twilio.}

  spec.homepage      = "https://github.com/paul-sx/huginn_twilio_conversation_agent"

  spec.license       = "MIT"


  spec.files         = Dir['LICENSE.txt', 'lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = Dir['spec/**/*.rb'].reject { |f| f[%r{^spec/huginn}] }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "huginn_agent"
  spec.add_runtime_dependency "twilio-ruby", "~> 5.62.0"
end
