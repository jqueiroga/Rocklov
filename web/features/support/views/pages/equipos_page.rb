class EquiposPage
  include Capybara::DSL

  def create_equipo(equipo)
    #checkpoint com timout explicito
    #Forma para utilizar um expect dentro de um PageObject
    page.has_css?("equipoForm")

    upload(equipo[:thumb]) if equipo[:thumb].length > 0

    find("input[placeholder$=equipamento]").set equipo[:nome]
    select_cat(equipo[:categoria]) if equipo[:categoria].length > 0
    find("#price").set equipo[:preco]

    click_button "Cadastrar"
  end

  def upload(filename)
    thumbFile = Dir.pwd + "/features/support/images/" + filename

    find("#thumbnail input[type=file]", visible: false).set thumbFile
  end

  def select_cat(category)
    find("#category").find("option", text: category).select_option
  end

  def equipo_list
    return find(".equipo-list")
  end
end
