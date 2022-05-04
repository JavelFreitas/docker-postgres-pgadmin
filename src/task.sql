-- Destruindo e recriando tabela caso ja exista
DROP TABLE IF EXISTS compra;

CREATE TABLE IF NOT EXISTS compra ( 
  ID_NF INTEGER NOT NULL,
  ID_ITEM INTEGER NOT NULL,
  COD_PROD INTEGER NOT NULL,
  VALOR_UNIT REAL NOT NULL,
  QUANTIDADE INTEGER NOT NULL,
  DESCONTO INTEGER
);

-- Inserindo itens iniciais

INSERT INTO compra (ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, QUANTIDADE, DESCONTO) VALUES 
(1, 1, 1, 25.00, 10, 5),
(1, 2, 2, 13.50, 3, NULL),
(1, 3, 3, 15.00, 2, NULL),
(1, 4, 4, 10.00, 1, NULL),
(1, 5, 5, 30.00, 1, NULL),
(2, 1, 3, 15.00, 4, NULL),
(2, 2, 4, 10.00, 5, NULL),
(2, 3, 5, 30.00, 7, NULL),
(3, 1, 1, 25.00, 5, NULL),
(3, 2, 4, 10.00, 4, NULL),
(3, 3, 5, 30.00, 5, NULL),
(3, 4, 2, 13.50, 7, NULL),
(4, 1, 5, 30.00, 10, 15),
(4, 2, 4, 10.00, 12, 5),
(4, 3, 1, 25.00, 13, 5),
(4, 4, 2, 13.50, 15, 5),
(5, 1, 3, 15.00, 3, NULL),
(5, 2, 5, 30.00, 6, NULL),
(6, 1, 1, 25.00, 22, 15),
(6, 2, 3, 15.00, 25, 20),
(7, 1, 1, 25.00, 10, 3),
(7, 2, 2, 13.50, 10, 4),
(7, 3, 3, 15.00, 10, 4),
(7, 4, 5, 30.00, 10, 1);

-- 1.a) Buscando itens sem desconto
SELECT id_nf, id_item, cod_prod, valor_unit FROM compra WHERE desconto IS NULL OR desconto <= 0;

-- 1.b) Buscando itens com desconto + valor_vendido = (valor_unit - (valor_unit*(desconto/100)))
SELECT id_nf, desconto, id_item, cod_prod, valor_unit, valor_unit - (valor_unit * ROUND((desconto * 1.0) / 100, 2)) AS valor_vendido FROM compra WHERE desconto IS NOT NULL OR desconto >= 0;

-- 1.c) Alterar nulo para 0 no desconto das compras
UPDATE compra SET desconto = 0 WHERE desconto IS NULL;
SELECT * FROM compra;