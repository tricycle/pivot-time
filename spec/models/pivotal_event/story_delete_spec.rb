require 'spec_helper'

describe PivotalEvent::StoryDelete do
  describe "handling XML posts" do
    describe "a pivotal event and its story," do
      before do
        @time = "2010/06/27 22:09:44 UTC"
        @desc = %(Peter Hollows added "make it work on Webkit")
        @xml = ERB.new(
          File.read("#{Rails.root}/spec/fixtures/pivotal/story_delete.xml.erb")
        ).result(binding)

        @event = PivotalEvent::Base.create_from_xml(@xml)
      end

      it "marks the story as deleted" do
        @event.story.state.should == 'deleted'
        @event.story.deleted_at.should == Time.parse(@time)
      end
    end
  end
end