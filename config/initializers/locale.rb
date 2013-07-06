# говорим библиотеке I18n, где искать наши переводы
I18n.load_path = Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
 
# устанавливаем локаль по умолчанию на что-либо другое, чем :en
I18n.default_locale = :ru