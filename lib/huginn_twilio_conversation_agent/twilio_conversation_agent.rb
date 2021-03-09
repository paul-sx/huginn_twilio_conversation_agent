module Agents
  class TwilioConversationAgent < Agent
    cannot_be_scheduled!
    cannot_create_events!
    no_bulk_receive!

    gem_dependency_check { defined?(Twilio) }

    description <<-MD
      The Twilio Conversation Agent receives and collects events and sends them via Twilio conversations.

      #{'## Include `twilio-ruby`` in your Gemfile to use this Agent!' if dependencies_missing?}

      It is assumed that events have a 'message', 'text', or 'sms' key, the value of which is sent as the content of the text message.  You can use EventFormattingAgent if your event does not provide these keys.
      
    MD

    def default_options
      {
        'account_sid' => 'ACxxxxxxxxxxxxxxxxxxxxxxxxxx',
        'auth_token' => 'xxxxxxxxxxxxxxxxxxxx',
        'conversation_sid' => 'CHxxxxxxxxxxxxxxxx',
        'expected_receive_period_in_days' => '1'
      }
    end

    def validate_options
      unless options['account_sid'].present? && options['auth_token'].present? && options['conversation_sid'].present? && options['expected_receive_period_in_days'].present?
        errors.add(:base, 'account_sid, auth_token, conversation_sid and expected_receive_period_in_days are all required')
      end
    end

    def receive(incoming_events)
      interpolate_with_each(incoming_events) do |event|
        message = (event.payload['message'].presence || event.payload['text'].presence || event.payload['sms'].presence).to_s
        author = (event.payload['author'].presence || event.payload['from'].presence).to_s
        if message.present?
          send_message message, author
        end
      end
    end



    def working?
      last_receive_at && last_receive_at > interpolated['expected_receive_period_in_days'].to_i.days.ago && !recent_error_logs?
    end

    def send_message(message, author)
      if author.present?
        client.conversations
          .conversations(interpolated['conversation_sid'])
          .messages
          .create( author: author, body: message )
      else
        client.conversations
          .conversations(interpolated['conversation_sid'])
          .messages
          .create( body: message )
      end
    end

    def client
      @client ||= Twilio::REST::Client.new interpolated['account_sid'], interpolated['auth_token']
    end

  end
end
