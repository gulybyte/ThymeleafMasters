CREATE TABLE IF NOT EXISTS profissao (
    id bigserial NOT NULL,
    nome character varying(255),
    CONSTRAINT profissao_pkey PRIMARY KEY (id)
);

INSERT INTO profissao(id, nome) VALUES (1, 'Programador Java');
INSERT INTO profissao(id, nome) VALUES (2, 'Programador PHP');
INSERT INTO profissao(id, nome) VALUES (3, 'Programador JavaScript');
INSERT INTO profissao(id, nome) VALUES (4, 'Programador Front-End');
INSERT INTO profissao(id, nome) VALUES (5, 'Programador C / C++');