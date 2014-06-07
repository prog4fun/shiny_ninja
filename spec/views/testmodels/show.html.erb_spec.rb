require 'rails_helper'

RSpec.describe "testmodels/show", :type => :view do
  before(:each) do
    @testmodel = assign(:testmodel, Testmodel.create!(
      :teststring => "Teststring",
      :testcheck => false,
      :testnumber => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Teststring/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
