-- criando o role para acessos entre admin e user
INSERT INTO role(id, nome_role) VALUES (1, 'ROLE_ADMIN');
INSERT INTO role(id, nome_role) VALUES (2, 'ROLE_USER');


-- inserindo dois usuarios bases para poder acessar o sistema admin(login: admin password: admin) e user(login: user passord: 123)
INSERT INTO usuario(id, login, senha) VALUES (1, 'admin', '$2a$10$XQ44XYOBateY8V.sHCgmhOqh8u6PxaUjKgRfIj2Xu1x9.yqHV9cty');
INSERT INTO usuario(id, login, senha) VALUES (2, 'user', '$2a$10$7/RXuG4fbbW1wffaYPnHLeKVtlTrY1gDUlhw2T8AMMyw5Ru4aT2GK');

-- inserindo um usuario criado com admin e outro como user basico
INSERT INTO usuarios_role(usuario_id, role_id) VALUES (1, 1);
INSERT INTO usuarios_role(usuario_id, role_id) VALUES (2, 2);