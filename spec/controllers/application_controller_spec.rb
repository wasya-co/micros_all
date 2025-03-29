
describe ApplicationController do
  render_views

  it "#home - includes alerts_notices" do
    ApplicationController.any_instance.stub(:notice) { "Yes, present." }
    get :home
    response.code.should eql '200'
  end
end

