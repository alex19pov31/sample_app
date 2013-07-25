# encoding: utf-8
Допустим(/^пользователь перешел на страницу регистрации$/) do
  visit signup_path
end

Допустим(/^ввел не корректные регистрационные данные$/) do
  @user_count = User.count
  click_button I18n.t('users.new.createaccount')
end

Тогда(/^пользователь должен увидеть сообщение с ошибкой$/) do
  page.should have_selector('div.alert.alert-error')
end

Тогда(/^общее колличество пользователей в базе должно остаться прежним$/) do
  @user_count.should == User.count
end


Допустим(/^ввел корректные регистрационные данные$/) do
  @user_count = User.count
  @user = {name: "Example User", email: "user@example.com", password: "foobar"}
  fill_in I18n.t('activerecord.attributes.user.name'),         with: @user[:name]
  fill_in I18n.t('activerecord.attributes.user.email'),        with: @user[:email]
  fill_in I18n.t('activerecord.attributes.user.password'),     with: @user[:password]
  fill_in I18n.t('users.new.confirm'), with: @user[:password]
  click_button I18n.t('users.new.createaccount')
end

Тогда(/^пользователь должен автоматически перейти на страницу профиля$/) do
  page.should have_selector('title', text: @user[:name])
end

Тогда(/^увидеть сообщение о успешной регистрации$/) do
  page.should have_selector('div.alert.alert-success')
end

Тогда(/^количество пользователей должно увеличиться на (\d+)$/) do |arg1|
  @user_count.should == (User.count - arg1.to_f)
end