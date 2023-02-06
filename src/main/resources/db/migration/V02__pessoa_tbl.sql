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
        ON DELETE NO ACTION
);

INSERT INTO pessoa(id, email, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
    (1, 'juan145@gmail.com', 'Juan', 'Soares', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
    (2, 'derikL0uis@gmail.com', 'Derick', 'Louis', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
    (3, 'Marcos6465@gmail.com', 'Marcos', 'Andrade', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
    (4, 'tester45@gmail.com', 'Test', 'Testing', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
    (5, 'Antonio878@gmail.com', 'Antonio', 'Rick', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
    (6, 'emailexample6@gmail.com', 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
    (7, 'emailexample7@gmail.com', 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');
INSERT INTO pessoa(id, email, nome, sobrenome, bairro, cep, cidade, ibge, rua, uf, sexo, profissao_id, cargo, data_nascimento)VALUES
    (8, 'emailexample8@gmail.com', 'name', 'subname', 'pos', '15897-9', 'city', '6544654', 'streeth', 'PR','MASCULINO', 1, 'GERENTE', '2003-01-12');