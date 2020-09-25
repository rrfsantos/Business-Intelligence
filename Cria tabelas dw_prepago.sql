
CREATE SEQUENCE public.dim_canal_sk_codcanal_seq;

CREATE TABLE public.dim_canal (
                sk_codcanal INTEGER NOT NULL DEFAULT nextval('public.dim_canal_sk_codcanal_seq'),
                nk_codcanal VARCHAR(10) NOT NULL,
                nomecanal VARCHAR(100) NOT NULL,
                CONSTRAINT sk_codcanal_pk PRIMARY KEY (sk_codcanal)
);


ALTER SEQUENCE public.dim_canal_sk_codcanal_seq OWNED BY public.dim_canal.sk_codcanal;

CREATE SEQUENCE public.dim_linha_sk_numlinha_seq;

CREATE TABLE public.dim_linha (
                sk_numlinha BIGINT NOT NULL DEFAULT nextval('public.dim_linha_sk_numlinha_seq'),
                nk_numlinha BIGINT NOT NULL,
                codcliente VARCHAR(10) NOT NULL,
                nomecliente VARCHAR(100) NOT NULL,
                sobrenomecliente VARCHAR(100) NOT NULL,
                email VARCHAR(100) NOT NULL,
                genero VARCHAR(3) NOT NULL,
                cpf VARCHAR(15) NOT NULL,
                dataoperacao DATE NOT NULL,
                tipooperacao VARCHAR(5) NOT NULL,
                motivobaixa VARCHAR(100) NOT NULL,
                CONSTRAINT sk_numlinha_pk PRIMARY KEY (sk_numlinha)
);


ALTER SEQUENCE public.dim_linha_sk_numlinha_seq OWNED BY public.dim_linha.sk_numlinha;

CREATE TABLE public.ft_recarga (
                tech1 BIGSERIAL,
                sk_codcanal INTEGER NOT NULL,
                sk_numlinha BIGINT NOT NULL,
                sk_data INTEGER NOT NULL,
                valorrecarga NUMERIC(10,2) NOT NULL
);
;CREATE UNIQUE INDEX idx_ft_recarga_pk ON "public".ft_recarga(tech1)
;
CREATE INDEX idx_ft_recarga_lookup ON "public".ft_recarga(sk_data, sk_codcanal, sk_numlinha, valorrecarga)
;


CREATE SEQUENCE public.dim_produto_sk_codproduto_seq;

CREATE TABLE public.dim_produto (
                sk_codproduto INTEGER NOT NULL DEFAULT nextval('public.dim_produto_sk_codproduto_seq'),
                nk_codproduto VARCHAR(10) NOT NULL,
                nomeproduto VARCHAR(100) NOT NULL,
                freqproduto VARCHAR(50) NOT NULL,
                valorproduto NUMERIC(10,2) NOT NULL,
                CONSTRAINT sk_produto_pk PRIMARY KEY (sk_codproduto)
);


ALTER SEQUENCE public.dim_produto_sk_codproduto_seq OWNED BY public.dim_produto.sk_codproduto;

CREATE TABLE public.ft_consumo (
                tech2 BIGSERIAL,
				sk_numlinha BIGINT NOT NULL,
                sk_codproduto INTEGER NOT NULL,
                sk_data INTEGER NOT NULL,
                valorconsumo NUMERIC(10,2) NOT NULL
);

;CREATE UNIQUE INDEX idx_ft_consumo_pk ON "public".ft_consumo(tech2)
;

CREATE INDEX idx_ft_consumo_lookup ON "public".ft_consumo(valorconsumo, sk_data, sk_codproduto, sk_numlinha)
;


ALTER TABLE public.ft_recarga ADD CONSTRAINT dim_canal_ft_recarga_fk
FOREIGN KEY (sk_codcanal)
REFERENCES public.dim_canal (sk_codcanal)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_consumo ADD CONSTRAINT dim_data_ft_consumo_fk
FOREIGN KEY (sk_data)
REFERENCES public.dim_data (sk_data)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_recarga ADD CONSTRAINT dim_data_ft_recarga_fk
FOREIGN KEY (sk_data)
REFERENCES public.dim_data (sk_data)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_consumo ADD CONSTRAINT dim_cliente_ft_consumo_fk
FOREIGN KEY (sk_numlinha)
REFERENCES public.dim_linha (sk_numlinha)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_recarga ADD CONSTRAINT dim_linha_ft_recarga_fk
FOREIGN KEY (sk_numlinha)
REFERENCES public.dim_linha (sk_numlinha)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_consumo ADD CONSTRAINT dim_produto_ft_consumo_fk
FOREIGN KEY (sk_codproduto)
REFERENCES public.dim_produto (sk_codproduto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;