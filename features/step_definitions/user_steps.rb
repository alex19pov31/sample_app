# encoding: utf-8
Допустим(/^пользователь перешел на страницу редактирования профиля$/) do
  @user = User.create(name: "Example", email: "test@test.ts", password: "password", password_confirmation: "password")
  visit edit_user_path(@user)
  page.should have_selector("title", text: I18n.t('users.edit.title'))
  page.should have_selector("h1", text: I18n.t('users.edit.welcome'))
  page.should have_link(I18n.t('users.edit.change'), href: "http://gravatar.com/emails")
end

Допустим(/^заполнил некорректные данные$/) do
  click_button I18n.t('users.edit.save')
end

Тогда(/^должно появится сообщение с описанием ошибки$/) do
  page.should have_selector("div.alert.alert-error")
end