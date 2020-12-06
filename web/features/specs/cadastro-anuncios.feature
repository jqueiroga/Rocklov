#language: pt

Funcionalidade: Cadastro de Anuncios
    Sendo usuário cadastrado no RockLov que possui equipamentos musicais
    Quero cadastrar meus equipamentos
    Para que eu possa disponibilizá-los para locação

    Contexto: Login
        * Login com "rei@yahoo.com" e "pwd123"

    @cadastro-equip
    Cenario: Novo equipamento
        Dado que acesso o formulário de cadastro de anúncios
            E que eu tenho o seguinte equipamento
            | thumb     | fender-sb.jpg |
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
        Quando submeto o cadastro desse item
        Então devo ver esse item no Dashboard

    @anuncio_sem_foto
    Esquema do Cenario: Tentativa de Cadastro de Anúncios
        Dado que acesso o formulário de cadastro de anúncios
            E que eu tenho o seguinte equipamento
            | thumb     | <foto>      |
            | nome      | <nome>      |
            | categoria | <categoria> |
            | preco     | <preco>     |
        Quando submeto o cadastro desse item
        Então deve conter a mensagem de alerta: "<saida>"

        Exemplos:
            | foto          | nome              | categoria | preco | saida                               |
            |               | Violao de Nylon   | Cordas    | 150   | Adicione uma foto no seu anúncio!   |
            | clarinete.jpg |                   | Outros    | 250   | Informe a descrição do anúncio!     |
            | mic.jpg       | Microfone Shure   |           | 100   | Informe a categoria                 |
            | trompete.jpg  | Trompete Clássico | Outros    |       | Informe o valor da diária           |
            | conga.jpg     | Trompete Clássico | Outros    | abc   | O valor da diária deve ser numérico |
            | conga.jpg     | Trompete Clássico | Outros    | 100c  | O valor da diária deve ser numérico |

