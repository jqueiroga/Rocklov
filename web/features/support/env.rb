require "allure-cucumber"
require "capybara"
require "capybara/cucumber"
require "faker"

#Criando uma constante com o ambiente a ser executado, conforme o default do cucumber.yml
CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV["CONFIG"]}"))

BROWSER = ENV["BROWSER"]

case ENV["BROWSER"]
when "firefox"
  @driver = :selenium
when "chrome"
  @driver = :selenium_chrome
when "firefox_headless"
  @driver = :selenium_headless
when "chrome_headless"
  @driver = :selenium_chrome_headless
else
  raise "Variável de @drive está vazia, não é possível abrir navegador."
end

Capybara.configure do |config|
  config.default_driver = :selenium_headless
  config.app_host = CONFIG["url"]
  config.default_max_wait_time = 10
end

AllureCucumber.configure do |config|
  config.results_directory = "/logs"
  config.clean_results_directory = true
end
