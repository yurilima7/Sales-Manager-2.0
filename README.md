# Sales Manager
## :memo: Descrição do Projeto
<p>O projeto Sales Manager tem como objetivo a reconstrução de uma aplicação mobile de mesmo nome, para realizar o gerenciamento de vendas da maneira mais simples possível e a prática de novos conceitos na implementação de um app utilizando flutter.</p>
<p>Clique aqui (https://github.com/yurilima7/Sales-Manager) para acessar o projeto anterior.</p>

## :books: Funcionalidades
* Sistema de Cadastro com E-Mail e Senha
* Sistema de Login com E-Mail e Senha
* Cadastro dos clientes do usuário
* Registro das compras do cliente 
* Exclusão de cliente
* Exclusão de compras do cliente
* Controle dos valores recebidos, valores a receber e total em vendas do usuário
* Visualizar dados dos clientes como endereço, telefone, compras e o total da divida
* Registro de pagamentos dos clientes

## 🎬 Demonstração da aplicação em GIFs
![cadastro funcionando](sales_manager\assets\gifs\register.gif)
![login funcionando](sales_manager\assets\gifs\login.gif)
![cadastro de cliente funcionando](sales_manager\assets\gifs\AddClient.gif)
![registro de venda funcionando](sales_manager\assets\gifs\AddVenda.gif)
![exclusão de compras funcionando](sales_manager\assets\gifs\DelVenda.gif)

## :wrench: Tecnologias Utilizadas
* Flutter
* Dart

## :computer: Bibliotecas e Ferramentas
* Provider para gerenciar o acesso aos dados e controle de rotas
* Bloc para o gerencimento de estado
* Match para implementar as verificações, exemplo: se está buscando, deletando, editando e os dados sendo carregados do banco
* Shared Prefereces para armazenar accessToken do usuário ao fazer login (persistência)
* Json Rest Server para simular o backend para armazenamento dos dados
* Brasil Fields para as máscaras de telefone e moedas nacionais
* Intl para formatação dos textos de valores, ex: R$ 100,00
* Top Snackbar para mensagens de comunicação com usuário, como de sucesso, erro e informação para suas ações na aplicação
* Dio para fazer as requisições HTTP
* Flutter Bloc para auxiliar na implementação do padrão bloc
* Flutter Dot Env para execução do arquivo .env que possui a url do backend

## :information_source: Como Usar

Para executar corretamente esta aplicação você precisará:
* Git e Node JS instalados
* Flutter já configurado (de preferência com Flutter Version Manager)
* Adicionar um arquivo .env com o endereço de ip da máquina utilizada, ex: backend_base_url=http://seuIP:8080
* Configurar o Json Rest Server para simulação do backend
* Configurado o Json Rest Server, navegar até a pasta databases e executar o comando jrs run no terminal

## :memo: Licença
Esse projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes

## :dart: Status do Projeto
Concluído.
