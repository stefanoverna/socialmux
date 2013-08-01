module Socialmux
  class Result < Struct.new(:user, :event)

    def method_missing(name, *args, &block)
      Event.all.each do |event_name|
        if name.to_s == "#{event_name}?"
          return event == event_name
        end
      end

      super
    end
  end
end

