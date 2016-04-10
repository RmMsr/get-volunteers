# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#

email = ENV['ADMIN_EMAIL'] || shell.ask('Which email do you want use for logging into admin?')
password  = ENV['ADMIN_PASSWORD'] || shell.ask('Tell me the password to use:', :echo => false)

shell.say ""

account = Account.new(
    :email => email,
    :name => "Foo",
    :surname => "Bar",
    :password => password,
    :password_confirmation => password,
    :role => "admin")

if account.valid?
  account.save
  shell.say "================================================================="
  shell.say "Account has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   email: #{email}"
  shell.say "   password: #{?* * password.length}"
  shell.say "================================================================="
else
  shell.say "Sorry, but something went wrong!"
  shell.say ""
  account.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""
