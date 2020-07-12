SELECT * FROM cliente;

SELECT * FROM telefone;

SELECT * FROM endereco;

SELECT * FROM carro;

SELECT * FROM modelo;

SELECT * FROM aluguel;

SELECT * FROM carro c INNER JOIN modelo m ON c.codmodelo = m.codmodelo;

SELECT * FROM cliente c INNER JOIN endereco e ON c.codendereco = e.codendereco;

SELECT * FROM aluguel alu
INNER JOIN cliente cli ON alu.codcliente = cli.codcliente
INNER JOIN carro car ON alu.codcarro = car.codcarro;

SELECT * FROM telefone INNER JOIN cliente ON telefone.codcliente = cliente.codcliente;

SELECT * FROM cliente;





-- SEQUENCE PARA CHAVE PRIMÁRIA DA TABELA MODELO
CREATE SEQUENCE "modelo_sequence" START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- CRIANDO TABELA MODELO
CREATE TABLE modelo (
	codmodelo INTEGER PRIMARY KEY,
	modelo VARCHAR(15) NOT NULL
);

-- CRIANDO A TRIGGER PQ O ORACLE 11g É VELHO
CREATE OR REPLACE TRIGGER increment_pk_modelo
BEFORE INSERT ON modelo FOR EACH ROW WHEN (new.codmodelo IS NULL)
DECLARE
BEGIN
  :new.codmodelo := "modelo_sequence".NEXTVAL;
END increment_pk_modelo;

-- INSERINDO REGISTROS
INSERT INTO modelo (modelo) VALUES('Sedã');
INSERT INTO modelo (modelo) VALUES('Mini-van');
INSERT INTO modelo (modelo) VALUES('Ret');

-- SELECIONANDO TODOS OS VALORES DA TABELA MODELO
SELECT * FROM modelo;




-- ///////////////////////////////////////////////////////////////////




-- SEQUENCE PARA TABELA CARRO
CREATE SEQUENCE "carro_sequence" START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- TABELA CARRO
CREATE TABLE carro (
	codcarro INTEGER PRIMARY KEY,
	precodiaria NUMBER(5, 2) NOT NULL,
	placa VARCHAR(8) NOT NULL,
	ano INTEGER NOT NULL,
	cor VARCHAR(15) NOT NULL,
	codmodelo INTEGER NOT NULL REFERENCES modelo (codmodelo)
);


-- TRIGGER PARA INCREMENTAR AUTOMATICAMENTE O CODCARRO
CREATE OR REPLACE TRIGGER increment_pk_carro
BEFORE INSERT ON carro FOR EACH ROW WHEN (new.codcarro IS NULL)
DECLARE
BEGIN
  :new.codcarro := "carro_sequence".NEXTVAL;
END increment_pk_carro;

-- INSERINDO REGISTROS
INSERT INTO carro (precodiaria, placa, ano, cor, codmodelo) VALUES(70, 'BGTF4567', 2015, 'Preto', 1);
INSERT INTO carro (precodiaria, placa, ano, cor, codmodelo) VALUES(60, 'MGTS4567', 2017, 'Preto', 2);
INSERT INTO carro (precodiaria, placa, ano, cor, codmodelo) VALUES(100, 'MUJY4567', 2018, 'Preto', 3);
INSERT INTO carro (precodiaria, placa, ano, cor, codmodelo) VALUES(60, 'KIRF7859', 2019, 'Preto', 2);
INSERT INTO carro (precodiaria, placa, ano, cor, codmodelo) VALUES(70, 'PLOK2548', 2014, 'Preto', 1);

-- SELECIONANDO
SELECT * FROM carro;




-- ///////////////////////////////////////////////////////////////////




-- SEQUENCE PARA TABELA DE ENDEREÇO
CREATE SEQUENCE "endereco_sequence" START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- TABELA DE ENDEREÇO
CREATE TABLE endereco (
	codendereco INTEGER PRIMARY KEY,	
	ndacasa INTEGER NOT NULL,
	bairro VARCHAR(70) NOT NULL,
	estado VARCHAR(20) NOT NULL,
	cidade VARCHAR(20) NOT NULL
);

-- TRIGGER PARA AUTO INCREMENT
CREATE OR REPLACE TRIGGER increment_pk_endereco
BEFORE INSERT ON endereco FOR EACH ROW WHEN (new.codendereco IS NULL)
DECLARE
BEGIN
  :new.codendereco := "endereco_sequence".NEXTVAL;
END increment_pk_endereco;

-- INSERINDO VALORES
INSERT INTO endereco (ndacasa, bairro, cidade, estado) VALUES(1, 'Laranjeiras','Serra','ES');
INSERT INTO endereco (ndacasa, bairro, cidade, estado) VALUES(12, 'Carapina','Serra','ES');
INSERT INTO endereco (ndacasa, bairro, cidade, estado) VALUES(2, 'Jacaraipe','Serra','ES');
INSERT INTO endereco (ndacasa, bairro, cidade, estado) VALUES(22, 'Barcelona','Serra','ES');
INSERT INTO endereco (ndacasa, bairro, cidade, estado) VALUES(52, 'Porto canoa','Serra','ES');
INSERT INTO endereco (ndacasa, bairro, cidade, estado) VALUES(78, 'Novo Horizonte','Serra','ES');

-- SELECIONANDO TABELA ENDEREÇO
SELECT * FROM endereco;




-- ///////////////////////////////////////////////////////////////////




-- SEQUENCE PARA TABELA DE ENDEREÇO
CREATE SEQUENCE "cliente_sequence" START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- CRIANDO TABELO CLIENTE
CREATE TABLE cliente (
	codcliente INTEGER PRIMARY KEY,	
	cnh INTEGER NOT NULL,
	nome VARCHAR(20) NOT NULL,
	codendereco INTEGER NOT NULL REFERENCES endereco (codendereco)
);

-- CRIANDO TRIGGER
CREATE OR REPLACE TRIGGER increment_pk_cliente
BEFORE INSERT ON cliente FOR EACH ROW WHEN (new.codcliente IS NULL)
DECLARE
BEGIN
  :new.codcliente := "cliente_sequence".NEXTVAL;
END increment_pk_cliente;

-- INSERINDO DADOS
INSERT INTO cliente (cnh, nome, codendereco) VALUES(11234567890, 'MARCIA', 1);
INSERT INTO cliente (cnh, nome, codendereco) VALUES(03445566723, 'JOSÉ', 2);
INSERT INTO cliente (cnh, nome, codendereco) VALUES(89756342098, 'JOÂO', 3);
INSERT INTO cliente (cnh, nome, codendereco) VALUES(90876543762, 'PAULO', 4);
INSERT INTO cliente (cnh, nome, codendereco) VALUES(55346787872, 'TADEU', 5);
INSERT INTO cliente (cnh, nome, codendereco) VALUES(33489765765, 'MATHEUS', 6);

-- SELECIONANDO CLIENTES
SELECT * FROM cliente;




-- ///////////////////////////////////////////////////////////////////




-- CRIANDO SEQUENCE PARA TABELA ALUGA
CREATE SEQUENCE "aluguel_sequence" START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- CRIANDO TABELA ALUGA
CREATE TABLE aluguel (
	codaluguel INTEGER PRIMARY KEY,	
	datalocacao DATE NOT NULL,
	datadevolucao DATE,
	codcliente INTEGER NOT NULL REFERENCES cliente (codcliente),
	codcarro INTEGER NOT NULL
);

-- CRIANDO A TRIGGER PARA INCREMENTAR A SEQUENCE
CREATE OR REPLACE TRIGGER increment_pk_aluguel
BEFORE INSERT ON aluguel FOR EACH ROW WHEN (new.codaluguel IS NULL)
DECLARE
BEGIN
  :new.codaluguel := "aluguel_sequence".NEXTVAL;
END increment_pk_aluguel;

-- INSERINDO DADOS
INSERT INTO aluguel (datalocacao, datadevolucao, codcliente, codcarro) VALUES(TO_DATE('12/10/2012', 'DD/MM/YYYY'), TO_DATE('10/10/2012', 'DD/MM/YYYY'), 1, 1);
INSERT INTO aluguel (datalocacao, datadevolucao, codcliente, codcarro) VALUES(TO_DATE('05/06/2020', 'DD/MM/YYYY'), TO_DATE('10/06/2020', 'DD/MM/YYYY'), 2, 2);
INSERT INTO aluguel (datalocacao, datadevolucao, codcliente, codcarro) VALUES(TO_DATE('30/04/2020', 'DD/MM/YYYY'), TO_DATE('20/05/2020', 'DD/MM/YYYY'), 3, 3);
INSERT INTO aluguel (datalocacao, datadevolucao, codcliente, codcarro) VALUES(TO_DATE('09/10/2018', 'DD/MM/YYYY'), TO_DATE('10/10/2018', 'DD/MM/YYYY'), 4, 4);
INSERT INTO aluguel (datalocacao, datadevolucao, codcliente, codcarro) VALUES(TO_DATE('20/09/2019', 'DD/MM/YYYY'), TO_DATE('25/09/2019', 'DD/MM/YYYY'), 5, 5);
INSERT INTO aluguel (datalocacao, datadevolucao, codcliente, codcarro) VALUES(TO_DATE('07/07/2017', 'DD/MM/YYYY'), TO_DATE('17/07/2017', 'DD/MM/YYYY'), 6, 6);

-- SELECIONANDO
SELECT * FROM aluguel;




-- ///////////////////////////////////////////////////////////////////




-- SEQUENCE TELEFONE
CREATE SEQUENCE "telefone_sequence" START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- TABLE
CREATE TABLE telefone (
	codtelefone INTEGER PRIMARY KEY,
	telefone VARCHAR(20) NOT NULL,
	codcliente INTEGER NOT NULL REFERENCES cliente (codcliente)
);

DROP TABLE telefone;


-- TRIGGER AUTO INCREMENT
CREATE OR REPLACE TRIGGER increment_pk_telefone
BEFORE INSERT ON telefone FOR EACH ROW WHEN (new.codtelefone IS NULL)
DECLARE
BEGIN
  :new.codtelefone := "telefone_sequence".NEXTVAL;
END increment_pk_telefone;

-- INSERTING
INSERT INTO telefone (telefone, codcliente) VALUES('27911111111', 1);
INSERT INTO telefone (telefone, codcliente) VALUES('27933333333', 2);
INSERT INTO telefone (telefone, codcliente) VALUES('27999999999', 3);
INSERT INTO telefone (telefone, codcliente) VALUES('27988888888', 4);
INSERT INTO telefone (telefone, codcliente) VALUES('27977777777', 5);
INSERT INTO telefone (telefone, codcliente) VALUES('27955555555', 6);

-- SELECIONANDO
SELECT * FROM telefone;





-- ///////////////////////////////////////////////////////////////////




COMMIT;
ROLLBACK;