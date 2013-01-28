###  METHODS ###

def create_visitor
  @visitor ||= { :name => "John Mclovin", :email => "example@example.com",
    :password => "foobar", :password_confirmation => "foobar" }
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "user_name", :with => @visitor[:name]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

### Givens ###

Given /^Im logged in$/ do
  create_user
  sign_in
end

Given /^I am not logged in$/ do
  visit 'users/sign_out'
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end


### When ###

When /^I sign in with valid credentials$/ do
  create_visitor
  sign_up
end

When /^I sign out$/ do
  visit 'users/sign_out'
end

When /^I signup with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign in with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "nothinghere")
  sign_up
end

When /^I sign in without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign in without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign in with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "foobar123")
  sign_up
end

When /^I return to the sight$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com"
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongfoobar123"
  sign_in
end

When /^I edit my account details$/ do
  click_link "Edit account"
  fill_in "user_name", :with => "Somenewname"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

### Thens ###

Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end


Then /^I should see an invalid email error message$/ do
  page.should have_content "Email is invalid."
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank."
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation."
end

Then /^I should see a mismatched passwords message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end
