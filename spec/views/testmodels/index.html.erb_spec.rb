require 'rails_helper'

RSpec.describe "testmodels/index", :type => :view do
  before(:each) do
    assign(:testmodels, [
      Testmodel.create!(
        :teststring => "Teststring",
        :testcheck => false,
        :testnumber => ""
      ),
      Testmodel.create!(
        :teststring => "Teststring",
        :testcheck => false,
        :testnumber => ""
      )
    ])
  end

  it "renders a list of testmodels" do
    render
    assert_select "tr>td", :text => "Teststring".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
