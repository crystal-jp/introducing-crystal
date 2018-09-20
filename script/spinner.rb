# frozen_string_literal: true

# Spinner controls command-line spinner.
module Spinner
  CI = ENV['CI'] == 'true'

  SPINNER_QUEUE = Queue.new

  SPINNER_MAIN_THREAD = Thread.new do
    spinners = %w[∙∙∙ ●∙∙ ∙●∙ ∙∙● ∙∙∙]
    clock = 0
    message = 'show progress message here...'
    loop do
      if CI
        message = SPINNER_QUEUE.shift
        puts message if message
        break if SPINNER_QUEUE.closed?
      else
        message = SPINNER_QUEUE.shift || message
        break if SPINNER_QUEUE.closed?

        print "\e[G\e[K  \e[33m#{spinners[clock % spinners.size]}\e[0m "
        print message
        clock += 1
      end
    end
  end

  SPINNER_TIMER_THREAD = Thread.new do
    loop do
      sleep 0.125
      break if SPINNER_QUEUE.closed?

      SPINNER_QUEUE << nil
    end
  end

  def self.start
    SPINNER_MAIN_THREAD.run
    SPINNER_TIMER_THREAD.run
  end

  def self.show(message)
    SPINNER_QUEUE << message
  end

  def self.stop
    SPINNER_QUEUE.close
  end
end
