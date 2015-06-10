module App
  def sign_in(user,password="password")
    visit "/#/sign_in"
    fill_in "email", with: user.email
    fill_in "password", with: password
    click_on "Sign in"
  end
end

RSpec.configure do |c|
  c.include App
end