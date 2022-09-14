CREATE TABLE IF NOT EXISTS profissao (
    id bigserial NOT NULL,
    nome character varying(255),
    CONSTRAINT profissao_pkey PRIMARY KEY (id)
);