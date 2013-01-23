require "spec_helper"

describe ApplicationHelper do
  describe "#post_format" do
    it "transforms line breaks to html" do

      helper.post_format("first line\nsecond line").should eql("<p>first line\n<br />second line</p>")
      helper.post_format("first line\n\nsecond line").should eql("<p>first line</p>\n\n<p>second line</p>")
    end
  end
end
