require 'test_helper'

module Tire

  class CreateTest < Test::Unit::TestCase

    context "Bulk import to different indices" do
      setup do
        @index = Tire::Index.new "dummy"
        @index_one = Tire::Index.new "dummy_one"
      end

      should "should handle the '_index' field" do
        Configuration.client.expects(:post).with do |url, json|
          url  == "#{Configuration.url}/_bulk" &&
          json =~ /\A{.*?"_index":"dummy".*?}}/ &&
          json =~ /\A{.*?"_index":"dummy_one".*?}}/m
        end.returns(mock_response('{}'), 200)
        Tire::Index.bulk_store [ {:id => '1', :title => 'One', :_index => 'dummy', :type => "blog_tag", :text=>'dummy bulk'}, {:id => '2', :title => 'Two', :_index => 'dummy_one',:type => "blog_tag",:text=>'another dummy bulk'} ]
      end

      should "should handle the 'index' field" do
#        Configuration.client.expects(:post).with do |url, json|
#          url  == "#{Configuration.url}/_bulk" &&
#        #  json =~ /\A{.*?"_index":"dummy".*?}}/
#        #  json =~ /\A{.*?"_index":"dummy_one".*?}}/
#        end.returns(mock_response('{}'), 200)
#        @index.bulk_store [ {:id => '1', :title => 'One', :_index => 'dummy', :type => "blog_tag", :text=>'dummy bulk'}, {:id => '2', :title => 'Two', :_index => 'dummy_one', :type => "blog_tag", :text=>'another dummy bulk'} ]
      end
    end
  end
end
