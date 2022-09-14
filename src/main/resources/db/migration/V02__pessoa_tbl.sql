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