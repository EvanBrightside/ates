# frozen_string_literal: true

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = { 'bootstrap.servers': '127.0.0.1:9092' }
    config.client_id = 'analytics_service'
    config.consumer_persistence = !Rails.env.development?
  end

  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  Karafka.producer.monitor.subscribe(
    WaterDrop::Instrumentation::LoggerListener.new(
      Karafka.logger,
      log_messages: true
    )
  )

  routes.draw do
    consumer_group :notifications do
      topic :accounts do
        consumer AccountChanges
      end

      topic :accounts_stream do
        consumer AccountChanges
      end

      topic :tasks_stream do
        consumer TasksChanges
      end

      topic :balance_stream do
        consumer BalanceChanges
      end
    end
  end
end

Karafka::Web.setup do |config|
  config.ui.sessions.secret = '51de86b0ae85fd80682f2e4ff0b5eca9b2f0000f34c8274ffe901b5739c410f2'
end

Karafka::Web.enable!

