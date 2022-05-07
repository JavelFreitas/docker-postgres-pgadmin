-- 2.Alunos) Criar tabela e inserir dados
CREATE TABLE Alunos(
    mat INTEGER NOT NULL,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    PRIMARY KEY (mat)
);

INSERT INTO Alunos (mat, nome, endereco, cidade) VALUES
(2015010101, 'JOSE DE ALENCAR', 'RUA DAS ALMAS', 'NATAL'),
(2015010102, 'JOÃO JOSÉ', 'AVENIDA RUY CARNEIRO', 'JOÃO PESSOA'),
(2015010103, 'MARIA JOAQUINA', 'RUA CARROSSEL','RECIFE'),
(2015010104, 'MARIA DAS DORES', 'RUA DAS LADEIRAS', 'FORTALEZA'),
(2015010105, 'JOSUÉ CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL'),
(2015010106, 'JOSUÉLISSON CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');

-- 2.Disciplinas) Criar tabela e inserir dados
CREATE TABLE Disciplinas(
    cod_disc VARCHAR(5) NOT NULL,
    nome_disc VARCHAR(255) NOT NULL,
    carga_hor INTEGER NOT NULL,
    PRIMARY KEY (cod_disc)
);

INSERT INTO Disciplinas (cod_disc, nome_disc, carga_hor) VALUES
('BD', 'BANCO DE DADOS', 100),
('POO', 'PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS', 100),
('WEB', 'AUTORIA WEB', 50),
('ENG', 'ENGENHARIA DE SOFTWARE', 80);

SELECT * FROM Disciplinas;

-- 2.Professores) Criar tabela e inserir dados
CREATE TABLE Professores(
    cod_prof INTEGER NOT NULL,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    PRIMARY KEY (cod_prof)
);

INSERT INTO Professores (cod_prof, nome, endereco, cidade) VALUES
(212131, 'NICKERSON FERREIRA', 'RUA MANAÍRA', 'JOÃO PESSOA'),
(122135, 'ADORILSON BEZERRA', 'AVENIDA SALGADO FILHO', 'NATAL'),
(192011, 'DIEGO OLIVEIRA', 'AVENIDA ROBERTO FREIRE', 'NATAL');

SELECT * FROM Professores;

-- 2.Turma) Criar tabela e inserir dados
CREATE TABLE Turma(
    cod_disc VARCHAR(5) NOT NULL,
    cod_turma INTEGER NOT NULL,
    cod_prof INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    horario VARCHAR(20),
    PRIMARY KEY (cod_disc, cod_turma, cod_prof, ano),
    FOREIGN KEY (cod_disc) REFERENCES disciplinas(cod_disc),
    FOREIGN KEY (cod_prof) REFERENCES professores(cod_prof));

INSERT INTO Turma (cod_disc, cod_turma, cod_prof, ano, horario) VALUES
('BD', 1, 212131, 2015, '11H-12H'),
('BD', 2, 212131, 2015, '13H-14H'),
('POO', 1, 192011, 2015, '08H-09H'),
('WEB', 1, 192011, 2015, '07H-08H'),
('ENG', 1, 122135, 2015, '10H-11H');

SELECT * FROM Turma;

-- 2.Historico) Criar tabela e inserir dados
CREATE TABLE Historico (
    mat INTEGER NOT NULL,
    cod_disc VARCHAR(5) NOT NULL,
    cod_turma INTEGER NOT NULL,
    cod_prof INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    frequencia INTEGER NOT NULL,
    nota FLOAT,
    FOREIGN KEY (mat) REFERENCES alunos(mat),
    FOREIGN KEY (cod_disc, cod_turma, cod_prof, ano) REFERENCES turma(cod_disc, cod_turma, cod_prof, ano)
);

INSERT INTO Historico (mat, cod_disc, cod_turma, cod_prof, ano, frequencia, nota) VALUES
(2015010101, 'BD', 2, 212131, 2015, 100, 6),
(2015010101, 'POO', 1, 192011, 2015, 100, 7),
(2015010101, 'WEB', 1, 192011, 2015, 50, 8),
(2015010101, 'ENG', 1, 122135, 2015, 80, 9),
(2015010102, 'BD', 1, 212131, 2015, 80, 9),
(2015010102, 'POO', 1, 192011, 2015, 90, 5),
(2015010102, 'WEB', 1, 192011, 2015, 40, 8),
(2015010102, 'ENG', 1, 122135, 2015, 10, 9),
(2015010103, 'BD', 1, 212131, 2015, 100, 10),
(2015010103, 'POO', 1, 192011, 2015, 100, 5),
(2015010103, 'WEB', 1, 192011, 2015, 50, 1),
(2015010103, 'ENG', 1, 122135, 2015, 80, 9),
(2015010104, 'BD', 1, 212131, 2015, 10, 1),
(2015010104, 'POO', 1, 192011, 2015, 10, 7),
(2015010104, 'WEB', 1, 192011, 2015, 5, 8),
(2015010104, 'ENG', 1, 122135, 2015, 8, 10),
(2015010105, 'BD', 2, 212131, 2015, 8, 10),
(2015010105, 'POO', 1, 192011, 2015, 8, 10),
(2015010105, 'WEB', 1, 192011, 2015, 20, 10),
(2015010105, 'ENG', 1, 122135, 2015, 60, 10),
(2015010106, 'BD', 2, 212131, 2015, 100, 10),
(2015010106, 'POO', 1, 192011, 2015, 100, 10),
(2015010106, 'WEB', 1, 192011, 2015, 50, 10),
(2015010106, 'ENG', 1, 122135, 2015, 80, 10);

SELECT * FROM Historico;

-- 2.a) Encontre a MAT dos alunos com nota em BD em 2015 menor que 5 (obs: BD = código da disciplinas).

SELECT mat FROM Historico WHERE cod_disc='BD' AND nota<5 AND ano=2015;

-- 2.b) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015.

SELECT mat, AVG(nota) AS media_notas
FROM Historico
WHERE cod_disc='POO' AND ano=2015
GROUP BY mat;

-- 2.c) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015 e que esta média seja superior a 6.
SELECT mat, AVG(nota) AS media_notas
FROM Historico
WHERE cod_disc='POO' AND ano=2015
GROUP BY mat
HAVING AVG(nota)>6;

-- 2.d) Encontre quantos alunos não são de Natal.
SELECT COUNT(mat)
FROM Alunos
WHERE cidade!='NATAL';