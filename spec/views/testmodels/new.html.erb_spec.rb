require 'rails_helper'

RSpec.describe "testmodels/new", :type => :view do
  before(:each) do
    assign(:testmodel, Testmodel.new(
      :teststring => "MyString",
      :testcheck => false,
      :testnumber => ""
    ))
  end

  it "renders new testmodel form" do
    render

    assert_select "form[action=?][method=?]", testmodels_path, "post" do

      assert_select "input#testmodel_teststring[name=?]", "testmodel[teststring]"

      assert_select "input#testmodel_testcheck[name=?]", "testmodel[testcheck]"

      assert_select "input#testmodel_testnumber[name=?]", "testmodel[testnumber]"
    end
  end
end
