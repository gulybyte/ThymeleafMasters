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
    CONSTRAINT uk_krvk2qx218dxa3ogdyplk0wxw UNIQUE (role_id, usuario_id),
    CONSTRAINT fkb4lgjns7jnrvtimlocbhgu9eu FOREIGN KEY (role_id)
        REFERENCES role (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkopcaagbsri62yny3hlxui91vb FOREIGN KEY (usuario_id)
        REFERENCES usuario (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);