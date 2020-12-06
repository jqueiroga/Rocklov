class DashPage
  include Capybara::DSL

  def goto_equipo_form
    click_button "Criar anúncio"
  end

  def on_dash?
    page.has_css?(".dashboard")
  end
end
