require 'rails_helper'

RSpec.describe "testmodels/edit", :type => :view do
  before(:each) do
    @testmodel = assign(:testmodel, Testmodel.create!(
      :teststring => "MyString",
      :testcheck => false,
      :testnumber => ""
    ))
  end

  it "renders the edit testmodel form" do
    render

    assert_select "form[action=?][method=?]", testmodel_path(@testmodel), "post" do

      assert_select "input#testmodel_teststring[name=?]", "testmodel[teststring]"

      assert_select "input#testmodel_testcheck[name=?]", "testmodel[testcheck]"

      assert_select "input#testmodel_testnumber[name=?]", "testmodel[testnumber]"
    end
  end
end
