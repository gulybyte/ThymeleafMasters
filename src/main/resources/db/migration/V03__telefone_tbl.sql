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