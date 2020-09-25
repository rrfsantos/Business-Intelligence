CREATE TABLE "public".canal
(
  codcanal VARCHAR(10) PRIMARY KEY
, nomecanal VARCHAR(100) 
)
;

CREATE TABLE "public".produto
(
  codproduto VARCHAR(10) PRIMARY KEY
, nomeproduto VARCHAR(100)
, valorproduto NUMERIC(10, 2)
, freqproduto VARCHAR(50)
)
;

CREATE TABLE "public".linha
(
  numlinha BIGINT PRIMARY KEY
, codcliente VARCHAR(10)
, nomecliente VARCHAR(100)
, sobrenomecliente VARCHAR(100)
, email VARCHAR(100)
, genero VARCHAR(3)
, cpf VARCHAR(15)
, tipooperacao VARCHAR(5)
, motivobaixa VARCHAR(100)
, dataoperacao DATE
)
;

CREATE TABLE "public".consumo
(
  dataconsumo DATE
, numlinha BIGINT
, codproduto VARCHAR(100)
, valorconsumo NUMERIC(12, 2)
)
;

CREATE TABLE "public".recarga
(
  datarecarga DATE
, numlinha BIGINT
, valorrecarga NUMERIC(12, 2)
, canalrecarga VARCHAR(100)
, codcanal BIGINT
)
;