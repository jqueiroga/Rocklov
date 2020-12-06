visit current_pathDado("Login com {string} e {string}") do |email, password|
  visit "/"
  @email = email

  @login_page.open
  @login_page.with(email, password)

  #Checkpoint para garantir que o usuário estará no Dashboard após login
  expect(@dash_Page.on_dash?).to be true
end

Dado("que acesso o formulário de cadastro de anúncios") do
  @dash_Page.goto_equipo_form
end

Dado("que eu tenho o seguinte equipamento") do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  @anuncio = table.rows_hash

  MongoDB.new.remove_equipo(@anuncio[:nome], @email)
end

Quando("submeto o cadastro desse item") do
  @equipos_page.create_equipo(@anuncio)
end

Então("devo ver esse item no Dashboard") do
  expect(@equipos_page.equipo_list).to have_content @anuncio[:nome]
  expect(@equipos_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

Então("deve conter a mensagem de alerta: {string}") do |expect_alert|
  expect(@alert.dark).to have_text expect_alert
end

#REMOVER ANUNCIOS
Dado("que tenho um anúncios para ser removido") do |table|
  #Executando um código JavaScript pela Capybara
  user_id = page.execute_script ("return localStorage.getItem('user')")

  #Carregando arquivo
  thumb = File.open(File.join(Dir.pwd, "features/support/images", table.rows_hash[:thumb]), "rb")

  #criando um Equipamento, com os dados do Cenários
  @equipo = {
    thumbnail: thumb,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }

  #Utilizando a API de equipo/POST para criar um equipamento na Base de Dados.
  EquipoService.new.create(@equipo, user_id)

 #visit current_path
end

Quando("eu solicito a exclusão do anúncio") do
  equipo = find(".equipo-list li", text: @equipo[:name])
  equipo.find(".delete-icon").click
end

Quando("confirmo a exclusão") do
  click_on "Sim"
end

Então("não devo ver o anúncio no meu dashboard") do
 result = page.has_no_css?(".equipo-list li", text: @equipo[:name]
 expect(result).to be true
end
