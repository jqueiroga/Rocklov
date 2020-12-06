describe "POST /signup" do
  context "CT-API008: Fluxo Principal - Cadastro de Novo usuários com Sucesso" do
    before(:all) do
      payload = { name: "Xandy Avião", email: "comandante@xandy.com", password: "pwd123" }
      puts "OBS.: Para garantir que o teste não falhe, fazemos uma 'garantia' para que o usuário não exista na base."
      MongoDB.new.remove_user(payload[:email])

      @result = Signup.new.create(payload)
    end

    it "Valida Status Code igual a 200" do
      expect(@result.code).to eql 200
    end

    it "Valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end
end
