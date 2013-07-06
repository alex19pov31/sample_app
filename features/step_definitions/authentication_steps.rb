# encoding: utf-8
Допустим(/^пользователь переходит на страницу авторизации$/) do
  visit signin_path
end

Если(/^он заполнит неверные данные авторизации$/) do
  click_button "Sign in"
end

Тогда(/^появиться сообщение о ошибке$/) do
  page.should have_selector('div.alert.alert-error')
end


Допустим(/^у пользователя есть зарегистированный аккаунт$/) do
  @user = User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
end

Если(/^пользователь заполнит верные данные авторизации$/) do
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

То(/^он автоматически попадет на страницу профиля$/) do
  page.should have_selector('title', text: @user.name)
end

То(/^появится ссылка выхода$/) do
  page.should have_link('Sign out', href: signout_path)
end