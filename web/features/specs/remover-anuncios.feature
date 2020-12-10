#language: pt

Funcionalidade: Cadastro de Anuncios
    Sendo usuário cadastrado no RockLov que possui equipamentos musicais
    Quero remover algum anuncio de equipamentos
    Para que eu possa manter minha dashboard atualizada


    Contexto: Login
        * Login com "spider@uol.com" e "pwd123"

    @remover_anuncio 
    Cenário: Remover um anúncio
        Dado que tenho um anúncios para ser removido
            | thumb     | telecaster.jpg |
            | nome      | Telescast      |
            | categoria | Cordas         |
            | preco     | 50             |
        Quando eu solicito a exclusão do anúncio
            E confirmo a exclusão
        Então não devo ver o anúncio no meu dashboard

    @wip
    Cenário: Desistir da Exclusão
        Dado que tenho um anúncios para ser removido
            | thumb     | conga.jpg |
            | nome      | Conga     |
            | categoria | Outros    |
            | preco     | 100       |
        Quando eu solicito a exclusão do anúncio
            Mas não confirmo a solicitação
        Então devo ver o anúncio no meu dashboard