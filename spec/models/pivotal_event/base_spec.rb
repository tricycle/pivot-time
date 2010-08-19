require 'spec_helper'

describe PivotalEvent::Base do
  describe "handling XML posts" do
    shared_examples_for "a pivotal event" do
      it "associates itself with a story" do
        @event.story.should be_present
      end

      it "associates itself to a story with the same ID as the Pivotal Tracker story" do
        @event.story.id.should == 1234
      end

      it "records the message sent in the Pivotal XML" do
        @event.description.should == %(Peter Hollows added "something")
      end

      it "records the time the event took place" do
        @event.created_at.should == Time.parse('2010/06/27 22:09:44 UTC')
      end
    end

    describe "for new stories" do
      before do
        @type = 'feature'
        @xml = ERB.new(
          File.read("#{Rails.root}/spec/fixtures/pivotal/add_story.xml.erb")
        ).result(binding)

        @event = PivotalEvent::Base.handle(@xml)
      end

      it_should_behave_like "a pivotal event"

      it "creates a new StoryCreate pivotal event" do
        @event.class.should == PivotalEvent::StoryCreate
      end
    end
  end
end