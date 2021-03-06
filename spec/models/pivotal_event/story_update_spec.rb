require 'spec_helper'

describe PivotalEvent::StoryUpdate do
  describe "handling XML posts" do
    describe "a pivotal event and its story," do
      before do
        @time = "2010/06/27 22:09:44 UTC"
        @desc = %(Peter Hollows added "make it work on Webkit")
      end

      Story::STATES.each do |action, state|
        describe "to #{action} a story" do
          it "marks the story as #{state}" do
            build_xml(state)
            @event.story.state.should == state.to_s
          end
        end
      end

      def build_xml(state)
        @state = state
        @xml = ERB.new(
          File.read("#{Rails.root}/spec/fixtures/pivotal/story_update.xml.erb")
        ).result(binding)

        @event = PivotalEvent::Base.create_from_xml(@xml)
      end
    end
  end
end
