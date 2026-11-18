-- ================================================================
-- PARTE 1 - TABELAS, CONSTRAINTS, SEQUENCES, TRIGGERS E COMENTARIOS
-- ================================================================

CREATE TABLE TB_USUARIO 
    ( 
     id_usuario VARCHAR2 (100)  NOT NULL , 
     email      VARCHAR2 (100)  NOT NULL , 
     senha      VARCHAR2 (255)  NOT NULL , 
     nome       VARCHAR2 (20) , 
     sobrenome  VARCHAR2 (20) , 
     photo_url  VARCHAR2 (200) , 
     latitude   NUMBER (10,8) , 
     longitude  NUMBER (11,8) 
    ) 
;

ALTER TABLE TB_USUARIO 
    ADD CONSTRAINT tb_usuario_pk PRIMARY KEY ( id_usuario ) ;

ALTER TABLE TB_USUARIO 
    ADD CONSTRAINT tb_usuario_email_uc UNIQUE ( email ) ;

CREATE TABLE TB_CATEGORIA 
    ( 
     id_categoria VARCHAR2 (100)  NOT NULL , 
     categoria    VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE TB_CATEGORIA 
    ADD CONSTRAINT tb_categoria_pk PRIMARY KEY ( id_categoria ) ;

ALTER TABLE TB_CATEGORIA 
    ADD CONSTRAINT tb_categoria_categoria_uc UNIQUE ( categoria ) ;

CREATE TABLE TB_USUARIO_CATEGORIA 
    ( 
     tb_categoria_id_categoria VARCHAR2 (100)  NOT NULL , 
     tb_usuario_id_usuario     VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE TB_USUARIO_CATEGORIA 
    ADD CONSTRAINT tb_usuario_categoria_pk PRIMARY KEY ( tb_categoria_id_categoria, tb_usuario_id_usuario ) ;

CREATE TABLE TB_PEDIDO 
    ( 
     id_pedido                 VARCHAR2 (100)  NOT NULL , 
     tb_categoria_id_categoria VARCHAR2 (100)  NOT NULL , 
     tb_usuario_id_usuario     VARCHAR2 (100)  NOT NULL , 
     titulo_pedido             VARCHAR2 (50)  NOT NULL , 
     tipo_publicacao           VARCHAR2 (50)  NOT NULL , 
     status                    VARCHAR2 (100)  NOT NULL , 
     descricao                 VARCHAR2 (500) , 
     dt_inicio                 DATE , 
     valor                     NUMBER (10,2) , 
     photo_url                 VARCHAR2 (200) , 
     caixinha                  NUMBER (10,2) , 
     recompensa                VARCHAR2 (300) , 
     nao_incluir_pagamento     CHAR (1) , 
     hora_inicio               DATE , 
     dt_final                  DATE , 
     hora_final                DATE , 
     latitude                  NUMBER (10,8) , 
     longitude                 NUMBER (11,8) , 
     dt_recompensa             DATE 
    ) 
;

ALTER TABLE TB_PEDIDO 
    ADD CONSTRAINT tb_ped_sta_ck 
    CHECK (status IN ('ABERTO', 'EM_ANDAMENTO', 'CONCLUIDO', 'CANCELADO'))
;


ALTER TABLE TB_PEDIDO 
    ADD CONSTRAINT tb_ped_tip_pub_ck 
    CHECK (tipo_publicacao IN ('AJUDA', 'OFERTA'))
;
ALTER TABLE TB_PEDIDO 
    ADD CONSTRAINT tb_pedido_pk PRIMARY KEY ( id_pedido ) ;

CREATE TABLE TB_CANDIDATURA_PEDIDO 
    ( 
     id_candidatura           VARCHAR2 (100)  NOT NULL , 
     tb_pedido_id_pedido      VARCHAR2 (100)  NOT NULL , 
     tb_usuario_id_usuario    VARCHAR2 (100)  NOT NULL , 
     dt_oferta                DATE  NOT NULL , 
     status                   VARCHAR2 (20)  NOT NULL , 
     status_pagamento         VARCHAR2 (20)  NOT NULL , 
     dt_confirmacao_pagamento DATE 
    ) 
;

ALTER TABLE TB_CANDIDATURA_PEDIDO 
    ADD CONSTRAINT tb_can_ped_sta_ck 
    CHECK (status IN ('PENDENTE', 'ACEITA', 'RECUSADA', 'CANCELADA'))
;


ALTER TABLE TB_CANDIDATURA_PEDIDO 
    ADD CONSTRAINT tb_can_ped_sta_pag_ck 
    CHECK (status_pagamento IN ('NAO_APLICAVEL', 'PENDENTE', 'CONFIRMADO'))
;
ALTER TABLE TB_CANDIDATURA_PEDIDO 
    ADD CONSTRAINT tb_candidatura_pedido_pk PRIMARY KEY ( id_candidatura ) ;

CREATE TABLE TB_FEEDBACKS 
    ( 
     id_feedback               VARCHAR2 (100)  NOT NULL , 
     tb_can_ped_id_candidatura VARCHAR2 (100)  NOT NULL , 
     estrelas_usu_ajudante     CHAR (1) , 
     estrelas_usu_pedido       CHAR (1) , 
     feedback_usu_ajudante     VARCHAR2 (500) , 
     feedback_usu_pedido       VARCHAR2 (500) , 
     dt_avaliacao_usu_ajudante DATE , 
     dt_avaliacao_usu_pedido   DATE 
    ) 
;

ALTER TABLE TB_FEEDBACKS 
    ADD CONSTRAINT tb_fee_est_aju_ck 
    CHECK (estrelas_usu_ajudante IN ('1', '2', '3', '4', '5'))
;


ALTER TABLE TB_FEEDBACKS 
    ADD CONSTRAINT tb_fee_est_ped_ck 
    CHECK (estrelas_usu_pedido IN ('1', '2', '3', '4', '5'))
;
ALTER TABLE TB_FEEDBACKS 
    ADD CONSTRAINT tb_feedbacks_pk PRIMARY KEY ( id_feedback ) ;

ALTER TABLE TB_FEEDBACKS 
    ADD CONSTRAINT tb_fee_id_can_uc UNIQUE ( tb_can_ped_id_candidatura ) ;

CREATE TABLE TB_NOTIFICACAO 
    ( 
     id_notificacao            VARCHAR2 (100)  NOT NULL , 
     tb_can_ped_id_candidatura VARCHAR2 (100)  NOT NULL , 
     tb_pedido_id_pedido       VARCHAR2 (100)  NOT NULL , 
     tb_usuario_id_usuario     VARCHAR2 (100)  NOT NULL , 
     tipo_notificacao          VARCHAR2 (30)  NOT NULL , 
     mensagem                  VARCHAR2 (500)  NOT NULL , 
     dt_criacao                DATE  NOT NULL , 
     lida                      CHAR (1)  NOT NULL 
    ) 
;

ALTER TABLE TB_NOTIFICACAO 
    ADD CONSTRAINT tb_not_lida_ck 
    CHECK (lida IN ('S', 'N'))
;
ALTER TABLE TB_NOTIFICACAO 
    ADD CONSTRAINT tb_notificacao_pk PRIMARY KEY ( id_notificacao ) ;

CREATE TABLE TB_DENUNCIA 
    ( 
     id_denuncia           VARCHAR2 (100)  NOT NULL , 
     tb_usuario_id_usuario VARCHAR2 (100)  NOT NULL , 
     id_usu_denunciado     VARCHAR2 (100)  NOT NULL , 
     dt_time_denuncia      DATE  NOT NULL , 
     motivo_denuncia       VARCHAR2 (100) , 
     mensagem              VARCHAR2 (500) 
    ) 
;

ALTER TABLE TB_DENUNCIA 
    ADD CONSTRAINT tb_denuncia_motivo_ck 
    CHECK (motivo_denuncia IN ('COMPORTAMENTO INADEQUADO','ASSÉDIO OU AMEAÇA','GOLPE OU FRAUDE','INFORMAÇÕES FALSAS','DISCRIMINAÇÃO','OUTRO'))
;
ALTER TABLE TB_DENUNCIA 
    ADD CONSTRAINT tb_denuncia_pk PRIMARY KEY ( id_denuncia ) ;

ALTER TABLE TB_CANDIDATURA_PEDIDO 
    ADD CONSTRAINT tb_can_ped_tb_ped_fk FOREIGN KEY 
    ( 
     tb_pedido_id_pedido
    ) 
    REFERENCES TB_PEDIDO 
    ( 
     id_pedido
    ) 
;

ALTER TABLE TB_CANDIDATURA_PEDIDO 
    ADD CONSTRAINT tb_can_ped_tb_usr_fk FOREIGN KEY 
    ( 
     tb_usuario_id_usuario
    ) 
    REFERENCES TB_USUARIO 
    ( 
     id_usuario
    ) 
;

ALTER TABLE TB_DENUNCIA 
    ADD CONSTRAINT tb_denuncia_tb_usuario_fk FOREIGN KEY 
    ( 
     tb_usuario_id_usuario
    ) 
    REFERENCES TB_USUARIO 
    ( 
     id_usuario
    ) 
;

ALTER TABLE TB_FEEDBACKS 
    ADD CONSTRAINT tb_fee_tb_can_ped_fk FOREIGN KEY 
    ( 
     tb_can_ped_id_candidatura
    ) 
    REFERENCES TB_CANDIDATURA_PEDIDO 
    ( 
     id_candidatura
    ) 
;

ALTER TABLE TB_NOTIFICACAO 
    ADD CONSTRAINT tb_not_tb_can_ped_fk FOREIGN KEY 
    ( 
     tb_can_ped_id_candidatura
    ) 
    REFERENCES TB_CANDIDATURA_PEDIDO 
    ( 
     id_candidatura
    ) 
;

ALTER TABLE TB_NOTIFICACAO 
    ADD CONSTRAINT tb_not_tb_ped_fk FOREIGN KEY 
    ( 
     tb_pedido_id_pedido
    ) 
    REFERENCES TB_PEDIDO 
    ( 
     id_pedido
    ) 
;

ALTER TABLE TB_NOTIFICACAO 
    ADD CONSTRAINT tb_not_tb_usr_fk FOREIGN KEY 
    ( 
     tb_usuario_id_usuario
    ) 
    REFERENCES TB_USUARIO 
    ( 
     id_usuario
    ) 
;

ALTER TABLE TB_PEDIDO 
    ADD CONSTRAINT tb_ped_tb_cat_fk FOREIGN KEY 
    ( 
     tb_categoria_id_categoria
    ) 
    REFERENCES TB_CATEGORIA 
    ( 
     id_categoria
    ) 
;

ALTER TABLE TB_PEDIDO 
    ADD CONSTRAINT tb_ped_tb_usr_fk FOREIGN KEY 
    ( 
     tb_usuario_id_usuario
    ) 
    REFERENCES TB_USUARIO 
    ( 
     id_usuario
    ) 
;

ALTER TABLE TB_USUARIO_CATEGORIA 
    ADD CONSTRAINT tb_usr_cat_tb_cat_fk FOREIGN KEY 
    ( 
     tb_categoria_id_categoria
    ) 
    REFERENCES TB_CATEGORIA 
    ( 
     id_categoria
    ) 
;

ALTER TABLE TB_USUARIO_CATEGORIA 
    ADD CONSTRAINT tb_usr_cat_tb_usr_fk FOREIGN KEY 
    ( 
     tb_usuario_id_usuario
    ) 
    REFERENCES TB_USUARIO 
    ( 
     id_usuario
    ) 
;

CREATE SEQUENCE TB_CANDIDATURA_PEDIDO_id_candi 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_CANDIDATURA_PEDIDO_id_candi 
BEFORE INSERT ON TB_CANDIDATURA_PEDIDO 
FOR EACH ROW 
WHEN (NEW.id_candidatura IS NULL) 
BEGIN 
    :NEW.id_candidatura := TB_CANDIDATURA_PEDIDO_id_candi.NEXTVAL; 
END;
/

CREATE SEQUENCE TB_CATEGORIA_id_categoria_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_CATEGORIA_id_categoria_TRG 
BEFORE INSERT ON TB_CATEGORIA 
FOR EACH ROW 
WHEN (NEW.id_categoria IS NULL) 
BEGIN 
    :NEW.id_categoria := TB_CATEGORIA_id_categoria_SEQ.NEXTVAL; 
END;
/

CREATE SEQUENCE TB_DENUNCIA_id_denuncia_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_DENUNCIA_id_denuncia_TRG 
BEFORE INSERT ON TB_DENUNCIA 
FOR EACH ROW 
WHEN (NEW.id_denuncia IS NULL) 
BEGIN 
    :NEW.id_denuncia := TB_DENUNCIA_id_denuncia_SEQ.NEXTVAL; 
END;
/

CREATE SEQUENCE TB_FEEDBACKS_id_feedback_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_FEEDBACKS_id_feedback_TRG 
BEFORE INSERT ON TB_FEEDBACKS 
FOR EACH ROW 
WHEN (NEW.id_feedback IS NULL) 
BEGIN 
    :NEW.id_feedback := TB_FEEDBACKS_id_feedback_SEQ.NEXTVAL; 
END;
/

CREATE SEQUENCE TB_NOTIFICACAO_id_notificacao 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_NOTIFICACAO_id_notificacao 
BEFORE INSERT ON TB_NOTIFICACAO 
FOR EACH ROW 
WHEN (NEW.id_notificacao IS NULL) 
BEGIN 
    :NEW.id_notificacao := TB_NOTIFICACAO_id_notificacao.NEXTVAL; 
END;
/

CREATE SEQUENCE TB_PEDIDO_id_pedido_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_PEDIDO_id_pedido_TRG 
BEFORE INSERT ON TB_PEDIDO 
FOR EACH ROW 
WHEN (NEW.id_pedido IS NULL) 
BEGIN 
    :NEW.id_pedido := TB_PEDIDO_id_pedido_SEQ.NEXTVAL; 
END;
/

CREATE SEQUENCE TB_USUARIO_id_usuario_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TB_USUARIO_id_usuario_TRG 
BEFORE INSERT ON TB_USUARIO 
FOR EACH ROW 
WHEN (NEW.id_usuario IS NULL) 
BEGIN 
    :NEW.id_usuario := TB_USUARIO_id_usuario_SEQ.NEXTVAL; 
END;

-- Comentarios das tabelas
COMMENT ON TABLE TB_USUARIO IS 'Usuarios da plataforma, incluindo solicitantes, ajudantes e comerciantes.';
COMMENT ON TABLE TB_CATEGORIA IS 'Categorias utilizadas para classificar as publicacoes e interesses.';
COMMENT ON TABLE TB_USUARIO_CATEGORIA IS 'Associacao muitos para muitos entre usuarios e categorias de interesse.';
COMMENT ON TABLE TB_PEDIDO IS 'Publicacoes de solicitacoes de ajuda e ofertas comerciais.';
COMMENT ON TABLE TB_CANDIDATURA_PEDIDO IS 'Manifestacoes de interesse, escolhas e confirmacoes manuais de pagamento.';
COMMENT ON TABLE TB_FEEDBACKS IS 'Avaliacoes dos participantes de uma candidatura em datas independentes.';
COMMENT ON TABLE TB_NOTIFICACAO IS 'Avisos recebidos por usuarios relativos a pedidos e candidaturas.';
COMMENT ON TABLE tb_denuncia IS 'Registra denuncias realizadas por usuarios contra outros usuarios da plataforma.';

-- ================================================================
-- PARTE 2 - POPULACAO DAS TABELAS 
-- ================================================================

INSERT INTO TB_PEDIDO (id_pedido, tb_categoria_id_categoria, tb_usuario_id_usuario, titulo_pedido, tipo_publicacao, status, descricao, dt_inicio, valor, nao_incluir_pagamento) VALUES (3006, 1007, 2005, 'Configurar computador', 'AJUDA', 'CONCLUIDO', 'Ajuda voluntaria para configurar um computador.', DATE '2026-11-06', 0, 'S');
INSERT INTO TB_PEDIDO (id_pedido, tb_categoria_id_categoria, tb_usuario_id_usuario, titulo_pedido, tipo_publicacao, status, descricao, dt_inicio, valor, nao_incluir_pagamento) VALUES (3007, 1001, 2009, 'Cestas de frutas', 'OFERTA', 'EM_ANDAMENTO', 'Cestas de frutas da semana. Retirada a combinar.', DATE '2026-11-07', 20, 'N');
INSERT INTO TB_PEDIDO (id_pedido, tb_categoria_id_categoria, tb_usuario_id_usuario, titulo_pedido, tipo_publicacao, status, descricao, dt_inicio, valor, nao_incluir_pagamento) VALUES (3008, 1005, 2011, 'Livros para doacao', 'OFERTA', 'EM_ANDAMENTO', 'Livros usados gratuitos. Retirada no bairro.', DATE '2026-11-08', 0, 'S');
INSERT INTO TB_PEDIDO (id_pedido, tb_categoria_id_categoria, tb_usuario_id_usuario, titulo_pedido, tipo_publicacao, status, descricao, dt_inicio, valor, nao_incluir_pagamento) VALUES (3009, 1001, 2012, 'Marmitas caseiras', 'OFERTA', 'EM_ANDAMENTO', 'Marmitas do dia. Retirada mediante combinacao.', DATE '2026-11-09', 18, 'N');
INSERT INTO TB_PEDIDO (id_pedido, tb_categoria_id_categoria, tb_usuario_id_usuario, titulo_pedido, tipo_publicacao, status, descricao, dt_inicio, valor, nao_incluir_pagamento) VALUES (3010, 1005, 2006, 'Roupas seminovas', 'OFERTA', 'ABERTO', 'Pecas seminovas em bom estado.', DATE '2026-11-10', 12, 'N');

-- Candidaturas

INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4001, 3001, 2002, DATE '2026-11-02', 'ACEITA', 'CONFIRMADO', DATE '2026-11-10');
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4002, 3001, 2003, DATE '2026-11-02', 'RECUSADA', 'NAO_APLICAVEL', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4003, 3002, 2005, DATE '2026-11-03', 'ACEITA', 'NAO_APLICAVEL', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4004, 3002, 2006, DATE '2026-11-03', 'RECUSADA', 'NAO_APLICAVEL', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4005, 3003, 2008, DATE '2026-11-04', 'ACEITA', 'PENDENTE', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4006, 3003, 2009, DATE '2026-11-04', 'RECUSADA', 'NAO_APLICAVEL', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4007, 3004, 2011, DATE '2026-11-05', 'PENDENTE', 'PENDENTE', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4008, 3004, 2012, DATE '2026-11-05', 'CANCELADA', 'NAO_APLICAVEL', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4009, 3005, 2001, DATE '2026-11-06', 'ACEITA', 'PENDENTE', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4010, 3005, 2006, DATE '2026-11-06', 'RECUSADA', 'NAO_APLICAVEL', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4011, 3006, 2007, DATE '2026-11-07', 'ACEITA', 'NAO_APLICAVEL', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4012, 3006, 2008, DATE '2026-11-07', 'RECUSADA', 'NAO_APLICAVEL', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4013, 3007, 2001, DATE '2026-11-08', 'ACEITA', 'CONFIRMADO', DATE '2026-11-11');
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4014, 3007, 2002, DATE '2026-11-08', 'ACEITA', 'CONFIRMADO', DATE '2026-11-12');
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4015, 3007, 2006, DATE '2026-11-08', 'ACEITA', 'PENDENTE', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4016, 3008, 2004, DATE '2026-11-09', 'ACEITA', 'NAO_APLICAVEL', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4017, 3008, 2012, DATE '2026-11-09', 'ACEITA', 'NAO_APLICAVEL', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4018, 3009, 2001, DATE '2026-11-10', 'ACEITA', 'CONFIRMADO', DATE '2026-11-14');
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4019, 3009, 2005, DATE '2026-11-10', 'ACEITA', 'PENDENTE', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4020, 3010, 2008, DATE '2026-11-11', 'ACEITA', 'PENDENTE', NULL);
INSERT INTO TB_CANDIDATURA_PEDIDO (id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, dt_oferta, status, status_pagamento, dt_confirmacao_pagamento) VALUES (4021, 3010, 2009, DATE '2026-11-11', 'PENDENTE', 'PENDENTE', NULL);

-- Feedbacks

INSERT INTO TB_FEEDBACKS (id_feedback, tb_can_ped_id_candidatura, estrelas_usu_ajudante, estrelas_usu_pedido, feedback_usu_ajudante, feedback_usu_pedido, dt_avaliacao_usu_ajudante, dt_avaliacao_usu_pedido) VALUES (5001, 4001, '5', '5', 'Muito cuidadoso no servico.', 'Instrucoes claras.', DATE '2026-11-11', DATE '2026-11-12');
INSERT INTO TB_FEEDBACKS (id_feedback, tb_can_ped_id_candidatura, estrelas_usu_ajudante, estrelas_usu_pedido, feedback_usu_ajudante, feedback_usu_pedido, dt_avaliacao_usu_ajudante, dt_avaliacao_usu_pedido) VALUES (5002, 4003, '5', NULL, 'Ajudou com simpatia.', NULL, DATE '2026-11-05', NULL);
INSERT INTO TB_FEEDBACKS (id_feedback, tb_can_ped_id_candidatura, estrelas_usu_ajudante, estrelas_usu_pedido, feedback_usu_ajudante, feedback_usu_pedido, dt_avaliacao_usu_ajudante, dt_avaliacao_usu_pedido) VALUES (5003, 4011, '4', '5', 'Atendimento prestativo.', 'Pessoa muito educada.', DATE '2026-11-09', DATE '2026-11-10');
INSERT INTO TB_FEEDBACKS (id_feedback, tb_can_ped_id_candidatura, estrelas_usu_ajudante, estrelas_usu_pedido, feedback_usu_ajudante, feedback_usu_pedido, dt_avaliacao_usu_ajudante, dt_avaliacao_usu_pedido) VALUES (5004, 4013, '5', '5', 'Retirada ocorreu como combinado.', 'Comprador pontual.', DATE '2026-11-12', DATE '2026-11-12');
INSERT INTO TB_FEEDBACKS (id_feedback, tb_can_ped_id_candidatura, estrelas_usu_ajudante, estrelas_usu_pedido, feedback_usu_ajudante, feedback_usu_pedido, dt_avaliacao_usu_ajudante, dt_avaliacao_usu_pedido) VALUES (5005, 4016, '5', NULL, 'Tudo certo com a retirada.', NULL, DATE '2026-11-13', NULL);
INSERT INTO TB_FEEDBACKS (id_feedback, tb_can_ped_id_candidatura, estrelas_usu_ajudante, estrelas_usu_pedido, feedback_usu_ajudante, feedback_usu_pedido, dt_avaliacao_usu_ajudante, dt_avaliacao_usu_pedido) VALUES (5006, 4018, '4', '5', 'Produto entregue corretamente.', 'Boa comunicacao.', DATE '2026-11-15', DATE '2026-11-15');

-- Notificacoes

INSERT INTO TB_NOTIFICACAO (id_notificacao, tb_can_ped_id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, tipo_notificacao, mensagem, dt_criacao, lida) VALUES (6001, 4001, 3001, 2001, 'CANDIDATURA', 'Bruno demonstrou interesse na sua solicitacao.', DATE '2026-11-02', 'S');
INSERT INTO TB_NOTIFICACAO (id_notificacao, tb_can_ped_id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, tipo_notificacao, mensagem, dt_criacao, lida) VALUES (6002, 4001, 3001, 2002, 'PAGAMENTO', 'Pagamento confirmado pelo solicitante.', DATE '2026-11-10', 'N');
INSERT INTO TB_NOTIFICACAO (id_notificacao, tb_can_ped_id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, tipo_notificacao, mensagem, dt_criacao, lida) VALUES (6003, 4003, 3002, 2004, 'CANDIDATURA', 'Elisa se candidatou ao pedido.', DATE '2026-11-03', 'S');
INSERT INTO TB_NOTIFICACAO (id_notificacao, tb_can_ped_id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, tipo_notificacao, mensagem, dt_criacao, lida) VALUES (6004, 4013, 3007, 2009, 'INTERESSE', 'Ana demonstrou interesse na cesta de frutas.', DATE '2026-11-08', 'S');
INSERT INTO TB_NOTIFICACAO (id_notificacao, tb_can_ped_id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, tipo_notificacao, mensagem, dt_criacao, lida) VALUES (6005, 4013, 3007, 2001, 'PAGAMENTO', 'Pagamento confirmado pelo anunciante.', DATE '2026-11-11', 'N');
INSERT INTO TB_NOTIFICACAO (id_notificacao, tb_can_ped_id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, tipo_notificacao, mensagem, dt_criacao, lida) VALUES (6006, 4016, 3008, 2011, 'INTERESSE', 'Daniel demonstrou interesse nos livros.', DATE '2026-11-09', 'S');
INSERT INTO TB_NOTIFICACAO (id_notificacao, tb_can_ped_id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, tipo_notificacao, mensagem, dt_criacao, lida) VALUES (6007, 4005, 3003, 2007, 'CANDIDATURA', 'Henrique se candidatou ao pedido.', DATE '2026-11-04', 'S');
INSERT INTO TB_NOTIFICACAO (id_notificacao, tb_can_ped_id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, tipo_notificacao, mensagem, dt_criacao, lida) VALUES (6008, 4005, 3003, 2008, 'SELECAO', 'Sua candidatura foi aceita.', DATE '2026-11-05', 'N');
INSERT INTO TB_NOTIFICACAO (id_notificacao, tb_can_ped_id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, tipo_notificacao, mensagem, dt_criacao, lida) VALUES (6009, 4018, 3009, 2012, 'INTERESSE', 'Notificacao de teste para demonstrar DELETE.', DATE '2026-11-10', 'N');
INSERT INTO TB_NOTIFICACAO (id_notificacao, tb_can_ped_id_candidatura, tb_pedido_id_pedido, tb_usuario_id_usuario, tipo_notificacao, mensagem, dt_criacao, lida) VALUES (6010, 4019, 3009, 2005, 'SELECAO', 'Seu interesse foi aceito.', DATE '2026-11-10', 'N');

-- Denuncias
INSERT INTO tb_denuncia (tb_usuario_id_usuario, id_usu_denunciado, dt_time_denuncia, motivo_denuncia, mensagem) VALUES ('2002', '2003', SYSDATE, 'GOLPE OU FRAUDE', 'Usuario relatou tentativa de golpe em uma oferta comercial.');
INSERT INTO tb_denuncia (tb_usuario_id_usuario, id_usu_denunciado, dt_time_denuncia, motivo_denuncia, mensagem) VALUES ('2003', '2004', SYSDATE, 'INFORMAÇÕES FALSAS', 'Publicacao apresentava informacoes incorretas sobre o produto.');
INSERT INTO tb_denuncia (tb_usuario_id_usuario, id_usu_denunciado, dt_time_denuncia, motivo_denuncia, mensagem) VALUES ('2004', '2005', SYSDATE, 'ASSÉDIO OU AMEAÇA', 'Usuario relatou mensagens ofensivas durante uma negociacao.');
INSERT INTO tb_denuncia (tb_usuario_id_usuario, id_usu_denunciado, dt_time_denuncia, motivo_denuncia, mensagem) VALUES ('2005', '2002', SYSDATE, 'DISCRIMINAÇÃO', 'Usuario relatou tratamento discriminatorio durante uma interacao.');

COMMIT;

-- ================================================================
-- PARTE 3 - DEZ CONSULTAS DE NEGOCIO
-- ================================================================

-- CONSULTA 01
-- Quais pedidos de ajuda estao abertos ou em andamento?

SELECT id_pedido, titulo_pedido, status, valor
FROM tb_pedido
WHERE tipo_publicacao = 'AJUDA'
  AND status IN ('ABERTO', 'EM_ANDAMENTO')
ORDER BY valor;

-- CONSULTA 02
-- Quem fez cada pedido e a qual categoria pertence?

SELECT p.id_pedido, p.titulo_pedido,
       u.nome AS autor, c.categoria,
       p.tipo_publicacao
FROM tb_pedido p
INNER JOIN tb_usuario u
    ON p.tb_usuario_id_usuario = u.id_usuario
INNER JOIN tb_categoria c
    ON p.tb_categoria_id_categoria = c.id_categoria
ORDER BY p.id_pedido;

-- CONSULTA 03
-- Quantas pedidos existem por tipo e status?

SELECT tipo_publicacao, status,
       COUNT(*) AS quantidade
FROM tb_pedido
GROUP BY tipo_publicacao, status
ORDER BY tipo_publicacao, status;

-- CONSULTA 04
-- Qual a soma dos valores nas ofertas por categoria?

SELECT c.categoria,
       SUM(p.valor) AS soma_valores_anunciados
FROM tb_pedido p
INNER JOIN tb_categoria c
    ON p.tb_categoria_id_categoria = c.id_categoria
WHERE p.tipo_publicacao = 'OFERTA'
GROUP BY c.categoria
ORDER BY soma_valores_anunciados DESC;

-- CONSULTA 05
-- Qual a media, o menor e o maior valor das ajudas com valores?

SELECT c.categoria,
       ROUND(AVG(p.valor), 2) AS valor_medio,
       MIN(p.valor) AS menor_valor,
       MAX(p.valor) AS maior_valor
FROM tb_pedido p
INNER JOIN tb_categoria c
    ON p.tb_categoria_id_categoria = c.id_categoria
WHERE p.tipo_publicacao = 'AJUDA'
  AND p.valor > 0
GROUP BY c.categoria
ORDER BY c.categoria;

-- CONSULTA 06
-- Quantos pedidos cada usuario realizou, e quem não realizou nenhum?

SELECT u.id_usuario, u.nome,
       COUNT(p.id_pedido) AS total_publicacoes
FROM tb_usuario u
LEFT JOIN tb_pedido p
    ON u.id_usuario = p.tb_usuario_id_usuario
GROUP BY u.id_usuario, u.nome
ORDER BY total_publicacoes DESC, u.nome;

-- CONSULTA 07
-- Quantos pedidos existem por categoria?

SELECT c.categoria,
       COUNT(p.id_pedido) AS total_publicacoes
FROM tb_pedido p
RIGHT JOIN tb_categoria c
    ON p.tb_categoria_id_categoria = c.id_categoria
GROUP BY c.categoria
ORDER BY c.categoria;

-- CONSULTA 08
-- Quais ofertas possuem mais de um interessado aceito?

SELECT p.id_pedido, p.titulo_pedido,
       COUNT(c.id_candidatura) AS interessados_aceitos
FROM tb_pedido p
INNER JOIN tb_candidatura_pedido c
    ON p.id_pedido = c.tb_pedido_id_pedido
WHERE p.tipo_publicacao = 'OFERTA'
  AND c.status = 'ACEITA'
GROUP BY p.id_pedido, p.titulo_pedido
HAVING COUNT(c.id_candidatura) > 1
ORDER BY interessados_aceitos DESC;

-- CONSULTA 09
-- Quais ajudas remuneradas custam mais que a media?

SELECT id_pedido, titulo_pedido, valor
FROM tb_pedido
WHERE tipo_publicacao = 'AJUDA'
  AND valor > (
      SELECT AVG(valor)
      FROM tb_pedido
      WHERE tipo_publicacao = 'AJUDA'
        AND valor > 0
  )
ORDER BY valor DESC;

-- CONSULTA 10
-- Qual o valor potencial das ofertas com candidaturas aceitas?

SELECT p.id_pedido, p.titulo_pedido, p.valor,
       COUNT(c.id_candidatura) AS interessados_aceitos,
       p.valor * COUNT(c.id_candidatura) AS valor_potencial
FROM tb_pedido p
LEFT JOIN tb_candidatura_pedido c
    ON p.id_pedido = c.tb_pedido_id_pedido
   AND c.status = 'ACEITA'
WHERE p.tipo_publicacao = 'OFERTA'
GROUP BY p.id_pedido, p.titulo_pedido, p.valor
ORDER BY valor_potencial DESC;

-- ================================================================
-- PARTE 4 - UPDATE COM WHERE 
-- ================================================================

-- UPDATE 01 - marcar notificacao como lida
SELECT id_notificacao, mensagem, lida
FROM tb_notificacao;

UPDATE tb_notificacao
SET lida = 'S'
WHERE id_notificacao = '6002';

SELECT id_notificacao, mensagem, lida
FROM tb_notificacao
WHERE id_notificacao = '6002';

-- UPDATE 02 - confirmar pagamento de candidatura

SELECT id_candidatura, status, status_pagamento, dt_confirmacao_pagamento
FROM TB_CANDIDATURA_PEDIDO WHERE id_candidatura = '4015';

UPDATE TB_CANDIDATURA_PEDIDO
SET status_pagamento = 'CONFIRMADO',
    dt_confirmacao_pagamento = DATE '2026-11-16'
WHERE id_candidatura = '4015' AND status = 'ACEITA';

SELECT id_candidatura, status, status_pagamento, dt_confirmacao_pagamento
FROM TB_CANDIDATURA_PEDIDO WHERE id_candidatura = '4015';

-- ================================================================
-- PARTE 5 - DELETE COM WHERE 
-- ================================================================

-- DELETE 01 - deletar notificacao de teste

SELECT id_notificacao, mensagem
FROM tb_notificacao;

DELETE FROM tb_notificacao
WHERE id_notificacao = '6001';

SELECT *
FROM tb_notificacao
WHERE id_notificacao = '6001';

-- DELETE 02 - deletar notificacao INTERESSE de teste

SELECT id_notificacao, mensagem FROM TB_NOTIFICACAO WHERE id_notificacao = '6009';

DELETE FROM TB_NOTIFICACAO
WHERE id_notificacao = '6009' AND tipo_notificacao = 'INTERESSE';

SELECT id_notificacao, mensagem FROM TB_NOTIFICACAO WHERE id_notificacao = '6009';

COMMIT;