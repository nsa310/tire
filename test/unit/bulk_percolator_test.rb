require 'test_helper'

module Tire
  class CreateTest < Test::Unit::TestCase
    context "Bulk import for percolate and index" do
      setup do
        @index = Tire::Index.new "dummy"
      end

      should "should handle '_percolate' field" do
        Configuration.client.expects(:post).with do |url, json|
          url  == "#{Configuration.url}/_bulk" &&
          json =~ /\A{.*?"_percolate":"*".*?}}/m
        end.returns(mock_response('{}'), 200)
        Tire::Index.bulk_store [{:id=>'1', :title => 'one', :_index=>'dummy', :type=>'blog_tag', :text=>'dummy bulk percolate'}]
      end
    end
  end
end
