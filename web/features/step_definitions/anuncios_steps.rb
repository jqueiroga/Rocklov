Dado("Login com {string} e {string}") do |email, password|
  visit "/"
  @email = email

  @login_page.open
  @login_page.with(email, password)

  #Checkpoint para garantir que o usuário estará no Dashboard após login
  expect(@dash_page.on_dash?).to be true
end

Dado("que acesso o formulário de cadastro de anúncios") do
  @dash_page.goto_equipo_form
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
  expect(@dash_page.equipo_list).to have_content @anuncio[:nome]
  expect(@dash_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
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

  visit current_path
end

Quando("eu solicito a exclusão do anúncio") do
  @dash_page.request_removal(@equipo[:name])
  sleep 1 #Think Time
end

Quando("confirmo a exclusão") do
  @dash_page.confirm_removal
end

Quando("não confirmo a solicitação") do
  @dash_page.cancel_removal
end

Então("não devo ver o anúncio no meu dashboard") do
  expect(@dash_page.has_no_equipo?(@equipo[:name])).to be true
end

Então("devo ver o anúncio no meu dashboard") do
  expect(@dash_page.has_no_equipo?(@equipo[:name])).to be false
end
