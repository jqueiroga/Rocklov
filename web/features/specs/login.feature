#language: pt

Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "jqcaraujo@hotmail.com" e "pwd123"
        Então sou redirecionado para o Dashboard

    Esquema do Cenário: Tentativa em Logar

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "<email_input>" e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | email_input         | senha_input | mensagem_output                  |
            | jqcaraujo@gmail.com | senha123    | Usuário e/ou senha inválidos.    |
            | jqcaraujo@uol.com   | pwd123      | Usuário e/ou senha inválidos.    |
            | jqcaraujo&gmail.com | pwd123      | Oops. Informe um email válido!   |
            |                     | pwd123      | Oops. Informe um email válido!   |
            | jqcaraujo@gmail.com |             | Oops. Informe sua senha secreta! |


