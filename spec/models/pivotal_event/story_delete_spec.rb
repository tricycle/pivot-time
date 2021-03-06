require 'spec_helper'

describe PivotalEvent::StoryDelete do
  describe "handling XML posts" do
    before do
      @time = "2010/06/27 22:09:44 UTC"
      @desc = %(Peter Hollows added "make it work on Webkit")
      @xml = ERB.new(
        File.read("#{Rails.root}/spec/fixtures/pivotal/story_delete.xml.erb")
      ).result(binding)

      @event = PivotalEvent::Base.create_from_xml(@xml)
    end

    it "marks its own state as deleted" do
      @event.state.should == "deleted"
    end

    #it "records when the story was deleted" do
    #  @event.story.story_deleted_at.should == Time.parse(@time)
    #end
  end
end
