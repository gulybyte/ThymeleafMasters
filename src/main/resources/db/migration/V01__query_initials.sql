-- TABLES
CREATE TABLE IF NOT EXISTS profissao (
    id bigserial NOT NULL,
    nome character varying(255),
    CONSTRAINT profissao_pkey PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS pessoa (
    id bigserial NOT NULL,
    arquivo oid,
    bairro character varying(255),
    cargo character varying(255),
    cep character varying(255),
    cidade character varying(255),
    data_nascimento date,
    email character varying(60) NOT NULL,
    ibge character varying(255),
    idade integer NOT NULL,
    imagem text,
    nome character varying(15) NOT NULL,
    nome_file_arquivo character varying(255),
    rua character varying(255),
    sexo character varying(255) NOT NULL,
    sobrenome character varying(30) NOT NULL,
    tipo_file_arquivo character varying(255),
    uf character varying(255),
    profissao_id bigint,
    CONSTRAINT pessoa_pkey PRIMARY KEY (id),
    CONSTRAINT uk_mc87q8fpvldpdyfo9o5633o5l UNIQUE (email),
    CONSTRAINT fkdlajb93ifjvjmg3w1bbrdm6g3 FOREIGN KEY (profissao_id)
        REFERENCES profissao (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT pessoa_idade_check CHECK (idade >= 18 AND idade <= 100)
);
CREATE TABLE IF NOT EXISTS telefone (
    id bigserial NOT NULL,
    numero character varying(255) NOT NULL,
    pessoa_id bigint,
    CONSTRAINT telefone_pkey PRIMARY KEY (id),
    CONSTRAINT pessoa_id FOREIGN KEY (pessoa_id)
        REFERENCES pessoa (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
CREATE TABLE IF NOT EXISTS usuario (
    id bigserial NOT NULL,
    login character varying(255),
    senha character varying(255),
    CONSTRAINT usuario_pkey PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS role (
    id bigserial NOT NULL,
    nome_role character varying(255),
    CONSTRAINT role_pkey PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS usuarios_role (
    usuario_id bigint NOT NULL,
    role_id bigint NOT NULL,
    CONSTRAINT uk_krvk2qx218dxa3ogdyplk0wxw UNIQUE (role_id),
    CONSTRAINT fkb4lgjns7jnrvtimlocbhgu9eu FOREIGN KEY (role_id)
        REFERENCES role (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkopcaagbsri62yny3hlxui91vb FOREIGN KEY (usuario_id)
        REFERENCES usuario (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);





-- deleta o unique do usuario role para poder depois cria-lo novamente e assim poder ter varios usuarios cadastrados em um role
ALTER TABLE usuarios_role DROP
CONSTRAINT uk_krvk2qx218dxa3ogdyplk0wxw;

-- para poder cadastrar varios users em um role
ALTER TABLE usuarios_role
ADD CONSTRAINT uk_krvk2qx218dxa3ogdyplk0wxw UNIQUE(role_id, usuario_id);


-- criando o role para acessos entre admin e user
INSERT INTO role(id, nome_role) VALUES (1, 'ROLE_ADMIN');
INSERT INTO role(id, nome_role) VALUES (2, 'ROLE_USER');


-- inserindo dois usuarios bases para poder acessar o sistema admin(login: admin password: admin) e user(login: user passord: 123)
INSERT INTO usuario(id, login, senha) VALUES (1, 'admin', '$2a$10$XQ44XYOBateY8V.sHCgmhOqh8u6PxaUjKgRfIj2Xu1x9.yqHV9cty');
INSERT INTO usuario(id, login, senha) VALUES (2, 'user', '$2a$10$7/RXuG4fbbW1wffaYPnHLeKVtlTrY1gDUlhw2T8AMMyw5Ru4aT2GK');


--inserindo algumas profissoes para serem selcionadas
INSERT INTO profissao(id, nome) VALUES (1, 'Programador Java');
INSERT INTO profissao(id, nome) VALUES (2, 'Programador PHP');
INSERT INTO profissao(id, nome) VALUES (3, 'Programador JavaScript');
INSERT INTO profissao(id, nome) VALUES (4, 'Programador Front-End');
INSERT INTO profissao(id, nome) VALUES (5, 'Programador C / C++');


-- inserindo um usuario criado com admin e outro como user basico
INSERT INTO usuarios_role(usuario_id, role_id) VALUES (1, 1);
INSERT INTO usuarios_role(usuario_id, role_id) VALUES (2, 2);


INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2000, 'emailexample2000@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2001, 'emailexample2001@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2002, 'emailexample2002@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2003, 'emailexample2003@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2004, 'emailexample2004@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2005, 'emailexample2005@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2006, 'emailexample2006@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2007, 'emailexample2007@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2008, 'emailexample2008@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2009, 'emailexample2009@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2010, 'emailexample2010@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2011, 'emailexample2011@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2012, 'emailexample2012@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2013, 'emailexample2013@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2014, 'emailexample2014@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2015, 'emailexample2015@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2016, 'emailexample2016@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2017, 'emailexample2017@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2018, 'emailexample2018@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2019, 'emailexample2019@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2020, 'emailexample2020@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2021, 'emailexample2021@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2022, 'emailexample2022@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2023, 'emailexample2023@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2024, 'emailexample2024@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2025, 'emailexample2025@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2026, 'emailexample2026@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2027, 'emailexample2027@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2028, 'emailexample2028@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2029, 'emailexample2029@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2030, 'emailexample2030@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2031, 'emailexample2031@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2032, 'emailexample2032@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2033, 'emailexample2033@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2034, 'emailexample2034@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2035, 'emailexample2035@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2036, 'emailexample2036@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2037, 'emailexample2037@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2038, 'emailexample2038@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2039, 'emailexample2039@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2040, 'emailexample2040@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2041, 'emailexample2041@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2042, 'emailexample2042@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2043, 'emailexample2043@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, idade, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
(2044, 'emailexample2044@gmail.com', 18, 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
