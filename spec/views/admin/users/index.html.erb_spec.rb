require "rails_helper"

describe "admin/users/index.html.erb" do  
  before do
    40.times {FactoryGirl.create(:user)}
    @users = User.paginate page: params[:page], per_page: Settings.index.page
    render
  end

  it "request to users controller and show action" do
    expect(controller.request.path_parameters[:controller]).to eq "admin/users"
    expect(controller.request.path_parameters[:action]).to eq "index"

  end
  it "should list each user" do
    User.paginate(page: 1).each do |user|
      expect(rendered).to have_selector("li", text: user.name, text: "Detail")
    end
  end

  it "pagination" do
    expect(rendered).to have_css("div.pagination")
  end
end
