Before do
  @alert = Alert.new
  @dash_Page = DashPage.new
  @equipos_page = EquiposPage.new
  @login_page = LoginPage.new
  @signup_page = SignupPage.new

  #page.driver.browser.manage.window.maximize
  page.current_window.resize_to(1440, 900)
end

After do
  #cucumber captura e salva um screenshot temporário
  temp_screeshot = page.save_screenshot("logs/temp_screeshot.png")

  #Allure pega o screenshot capturado pelo Cucumber e adiciona no relatório.
  Allure.add_attachment(
    name: "Screenshot",
    type: Allure::ContentType::PNG,
    source: File.open(temp_screeshot),
  )
end
