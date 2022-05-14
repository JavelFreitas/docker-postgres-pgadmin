
<h1 align="center">Atlântico Academy</h1>
<p align="center">Atividade 02 SQL</p>
<h1 align="center">

<h2>Tópicos</h2>

* [Pre-requisitos](#pre-requisitos)
* [Sobre o projeto](#sobre-projeto)
* [Sobre a atividade](#sobre-atividade)
* [Questão 1](#questao-1)
* [Questão 2](#questao-2)
* [Tecnologias](#tecnologias)
* [Novidades](#novidade)

<h2 id="pre-requisitos">Pre-requisitos</h2>

1. Postgres
2. pgAdmin

> Uma alternativa aos dois anteriores é utilizar:
> * Docker 
> 
> Veja **Arquivos do Projeto** em **Sobre o Projeto**


<h2 id="sobre-projeto">Sobre o projeto</h2>
<h3>
Objetivo 
</h3>

* Aprender SQL
* Praticar comandos para DDL 
* Praticar comandos para DML

<h3>
Arquivos do Projeto 
</h3>

Arquivo | Finalidade
---: | :---
example.sql | Testar se o PostgreSQL está funcionando
task.sql | (Tabelas relacionadas a Compra) Resolver questão 1 da atividade
task2.sql | (Tabelas relacionadas a Escola) Resolver questão 2 da atividade
docker-compose-sample.yml | Base para criar docker-compose.yml
.gitignore | Impedir push de volume local criado pelo docker-compose e de arquivo docker-compose.yml com informações importantes.

> **docker-compose-sample.yml** tem comentários internamente explicando uso de cada argumento


<h2 id="sobre-atividade">Sobre a atividade</h2>
<h3 id="questao-1">
Questão 1 (task.sql) 
</h3>

* Criar tabela **compra**:

~~~PostgreSQL
CREATE TABLE IF NOT EXISTS compra ( 
  ID_NF INTEGER NOT NULL,
  ID_ITEM INTEGER NOT NULL,
  COD_PROD INTEGER NOT NULL,
  VALOR_UNIT REAL NOT NULL,
  QUANTIDADE INTEGER NOT NULL,
  DESCONTO INTEGER
);
~~~

* Inserir múltiplos dados em compra:

~~~PostgreSQL
INSERT INTO compra (ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, QUANTIDADE, DESCONTO) VALUES 
(1, 1, 1, 25.00, 10, 5),
...
(7, 4, 5, 30.00, 10, 1);
~~~

* Selecionar dados de compra:

~~~PostgreSQL
-- 1.b) Buscando itens com desconto + valor_vendido = (valor_unit - (valor_unit*(desconto/100)))
SELECT id_nf, desconto, id_item, cod_prod, valor_unit, valor_unit - (valor_unit * ROUND((desconto * 1.0) / 100, 2)) AS valor_vendido 
FROM compra 
WHERE desconto IS NOT NULL OR desconto >= 0;
~~~

* Atualizar dados de compra:

~~~PostgreSQL
-- 1.c) Alterar nulo para 0 no desconto das compras
UPDATE compra 
SET desconto = 0 
WHERE desconto IS NULL;
~~~

* Outros itens seguindo o modelo dos anteriores dentro do arquivo task.sql

<h3 id="questao-2"> Questão 2 (task2.sql)</h3>

* Criar tabelas e inserir dados dentro do arquivo **task2.sql**:
* Utilizando GROUP BY e função agregadora(AVG):

~~~PostgreSQL
-- 2.b) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015.

SELECT mat, AVG(nota) AS media_notas
FROM Historico
WHERE cod_disc='POO' AND ano=2015
GROUP BY mat;
~~~

* Utilizando HAVING:

~~~PostgreSQL
-- 2.c) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015 e que esta média seja superior a 6.
SELECT mat, AVG(nota) AS media_notas
FROM Historico
WHERE cod_disc='POO' AND ano=2015
GROUP BY mat
HAVING AVG(nota)>6;
~~~


<h2 id="tecnologias">Tecnologias</h2>

* [Postgres](https://www.postgresql.org) 
* [pgAdmin](https://www.pgadmin.org)
* [Docker](https://www.docker.com)
* [Docker Compose](https://docs.docker.com/compose/)
* [VSCode - Extensão Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)

<h2 id="novidade">Novidade</h2>

* Configuração do Docker
* Uso do Docker Compose