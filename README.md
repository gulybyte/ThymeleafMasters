<h1>Projeto de Estudo em Spring com Thymeleaf</h1>


<h2>Tecnologias Usadas:</h2>
<h3>SpringBoot, SpringSecurity, Thymeleaf, PostgesSQL, Materialize e JPA com Hibernate</h3>

<h2>Sistema Web não responsivo</h2>

<h1>O Que Você Encontra Aqui?:</h1>
<h2>Role entre tabelas para definir quem tem acesso a quais partes do sistema;</h2>
<h2>Authenticacao direto do banco com criptografia na senha;</h2>
<h2>CRUD de pessoa com estas funcionalidades:</h2>
<h3>INSERIR:</h3>
<h4>Arquivo(qualquer tipo, salvo no banco de dados em oid, podendo depois baixar ele novamente);</h4>
<h4>Data de nascimento que ate faz automanticamente o calculo de idade dado a data de nascimento(esta idade e validada no back-end com a regra que so pode ter entre 18 a 100 anos);</h4>
<h4>E-Mail apenas com uma valicao bem simples pro gMail (e uma validacao de unique);</h4>
<h4>Sexo(por selecionador que carrega direto do Front-End);</h4>
<h4>Nome e Sobrenome(com um tamanho maximo definido de caracteres);</h4>
<h4>Profissao(por selecionador que carrega do banco de dados em uma tabela relacionada);</h5>
<h4>Cargo(por selecionador que carrega por um enum);</h4>
<h4>Cep e Derivados, Usando aqui inclusive a WebService do cep que se adicionado um cep valido completa os outros campos automanticamente(tem um link no form pra caso queira gerar um cep valido);</h4>
<h4>Telefone com um relacionamento com outra tabela podendo varios telefones pra uma pessoa;</h4>
<h4>Imagem de usuario(em base64 no usuario);</h4>
<h3>ATUALIZAR:</h3>
<h4>todos e qualquer os dado(s);</h4>
<h3>CONSULTA:</h3>
<h4>Todos os dados do pessoa;</h4>
<h4>Todos os telefones de uma pessoa;</h4>
<h4>Consulta de pessoas pelo seu nome, sempre estando ordenado por id(usando trim e upperCase para melhor busca);</h4>
<h3>DELETE:</h3>
<h4>todos e qualquer os dado(s);</h3>
<h2>Paginacao em lista das pessoas;</h2>
<h2>Download de alguns dados de todas as pessoas em PDF por relatorio com jasper;</h2>

