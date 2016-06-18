describe "users/show" do

  before do
    assign(:user, User.create!(:name => "Amber", :email => "example@email.com", :password => "f4k3p455w0rd", :id => 1))
    assign(:event, Event.create!(:title => "Party", :date => '2015-05-09', :time => '2000-01-01 21:22:00 UTC', :description => "This is a party that I am having"))
    assign(:event2, Event.create!(:title => "Party2", :date => '2015-05-09', :time => '2000-01-01 21:22:00 UTC', :description => "This is a party that I am having"))
  end

  it "displays create link" do
    render
    expect(rendered).to include("Amber")
  end

end
