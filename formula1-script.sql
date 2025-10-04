DROP DATABASE IF EXISTS formula_1;
CREATE DATABASE formula_1;
USE formula_1;

-- ============================================================
--                        CREATE
-- ============================================================

-- Tabela Temporada
CREATE TABLE tb_formula1 (
	ano_temporada INT NOT NULL,
    dt_inicio     DATE NOT NULL,
    dt_final      DATE NOT NULL,
	PRIMARY KEY (ano_temporada)
);

-- Tabela Circuito
CREATE TABLE tb_circuito (
	circuito_code VARCHAR(5) NOT NULL,
	nome          VARCHAR(100) NOT NULL,
	pais          VARCHAR(30) NOT NULL,
	estilo        VARCHAR(50) NOT NULL,
	PRIMARY KEY (circuito_code)
);

-- Tabela Equipe
CREATE TABLE tb_equipe (
	equipe_code VARCHAR(3) NOT NULL,
	nome        VARCHAR(60) NOT NULL,
	pais        VARCHAR(15) NOT NULL,
	PRIMARY KEY (equipe_code)
);

-- Tabela Piloto 
CREATE TABLE tb_piloto (
	piloto_code    VARCHAR(20) NOT NULL,
	nome           VARCHAR(80) NOT NULL,
	nacionalidade  VARCHAR(30) NOT NULL,
	idade          INT NOT NULL,
	equipe_code    VARCHAR(3) NOT NULL,
	PRIMARY KEY (piloto_code),
	FOREIGN KEY (equipe_code) REFERENCES tb_equipe(equipe_code)
);

-- Tabela Treino 
CREATE TABLE tb_treino (
	treino_code    VARCHAR(3) NOT NULL,
	sessao         VARCHAR(30) NOT NULL,
	dia_treino     VARCHAR(20) NOT NULL,
	hr_treino      TIME NOT NULL,
	circuito_code  VARCHAR(5) NOT NULL,
	PRIMARY KEY (treino_code),
	FOREIGN KEY (circuito_code) REFERENCES tb_circuito(circuito_code)
);

-- Tabela Grande Prêmio
CREATE TABLE tb_grande_premio (
	gp_nome        VARCHAR(50) NOT NULL,
	dia_gp         VARCHAR(20) NOT NULL,
	data_gp        DATE NOT NULL,
	horario_gp     TIME NOT NULL,
	qtd_voltas     INT NOT NULL,
	circuito_code  VARCHAR(5) NOT NULL,
	ano_temporada  INT NOT NULL,
	PRIMARY KEY (gp_nome, ano_temporada),
	FOREIGN KEY (circuito_code) REFERENCES tb_circuito(circuito_code),
	FOREIGN KEY (ano_temporada) REFERENCES tb_formula1(ano_temporada)
);

-- Tabela Classificação por GP
CREATE TABLE rl_classificacao_gp (
	gp_nome     VARCHAR(50) NOT NULL,
	piloto_code VARCHAR(20) NOT NULL,
	posicao     INT NOT NULL,
	tempo       VARCHAR(12) NOT NULL,
	pontuacao   INT NOT NULL,
	PRIMARY KEY (gp_nome, piloto_code),
	FOREIGN KEY (gp_nome) REFERENCES tb_grande_premio(gp_nome),
	FOREIGN KEY (piloto_code) REFERENCES tb_piloto(piloto_code)
);

-- Tabela Classificação por Equipe
CREATE TABLE rl_classificacao_equipe (
	ano_temporada INT NOT NULL,
	equipe_code   VARCHAR(3) NOT NULL,
	posicao       INT NOT NULL,
	pontos        INT NOT NULL,
	vitorias      INT NOT NULL,
	podios        INT NOT NULL,
	PRIMARY KEY (equipe_code, ano_temporada),
	FOREIGN KEY (equipe_code) REFERENCES tb_equipe(equipe_code),
	FOREIGN KEY (ano_temporada) REFERENCES tb_formula1(ano_temporada)
);

-- Tabela Classificação por Piloto
CREATE TABLE rl_classificacao_piloto (
	ano_temporada INT NOT NULL,
	piloto_code   VARCHAR(20) NOT NULL,
	posicao       INT NOT NULL,
	pontos        INT NOT NULL,
	vitorias      INT NOT NULL,
	podios        INT NOT NULL,
	PRIMARY KEY (piloto_code, ano_temporada),
	FOREIGN KEY (piloto_code) REFERENCES tb_piloto(piloto_code),
	FOREIGN KEY (ano_temporada) REFERENCES tb_formula1(ano_temporada)
);

-- Tabela Grid de largada
CREATE TABLE rl_grid_gp (
	treino_code VARCHAR(3) NOT NULL,
	piloto_code VARCHAR(20) NOT NULL,
	tempo       TIME NOT NULL,
	PRIMARY KEY (piloto_code, treino_code),
	FOREIGN KEY (piloto_code) REFERENCES tb_piloto(piloto_code),
	FOREIGN KEY (treino_code) REFERENCES tb_treino(treino_code)
);

-- ============================================================
--                        INSERT
-- ============================================================

INSERT INTO tb_formula1 (ano_temporada, dt_inicio, dt_final)
VALUES (2025, '2025-03-01', '2025-11-30');

INSERT INTO tb_circuito (circuito_code, nome, pais, estilo)
VALUES
('MON', 'Circuit de Monaco', 'Mônaco', 'Rua'),
('IMOL', 'Autodromo Enzo e Dino Ferrari (Imola)', 'Itália', 'Permanente'),
('MIAM', 'Miami International Autodrome', 'Estados Unidos', 'Rua'),
('AUST', 'Circuit of the Americas (Austin)', 'Estados Unidos', 'Permanente'),
('SPA',  'Circuit de Spa-Francorchamps', 'Bélgica', 'Permanente');

INSERT INTO tb_treino (treino_code, sessao, dia_treino, hr_treino, circuito_code)
VALUES
('TQ2', 'Qualificação', 'sábado', '16:00:00', 'IMOL');

INSERT INTO tb_equipe (equipe_code, nome, pais)
VALUES
 ('RBR', 'Red Bull Racing', 'Áustria'),
 ('MCL', 'McLaren', 'Reino Unido'),
 ('MER', 'Mercedes', 'Alemanha'),
 ('FER', 'Ferrari', 'Itália'),
 ('AST', 'Aston Martin', 'Reino Unido'),
 ('ALP', 'Alpine', 'França'),
 ('HAS', 'Haas', 'Estados Unidos'),
 ('WIL', 'Williams', 'Reino Unido'),
 ('RBL', 'Racing Bulls', 'Reino Unido'), 
 ('SAU', 'Kick Sauber', 'Suíça');

INSERT INTO tb_piloto (piloto_code, nome, nacionalidade, idade, equipe_code)
VALUES
  ('VER', 'Max Verstappen', 'Países Baixos', 27, 'RBR'),
  ('TSU', 'Yuki Tsunoda', 'Japão', 25, 'RBR'),
  ('NOR', 'Lando Norris', 'Reino Unido', 25, 'MCL'),
  ('PIA', 'Oscar Piastri', 'Austrália', 22, 'MCL'),
  ('RUS', 'George Russell', 'Reino Unido', 26, 'MER'),
  ('ANT', 'Andrea Kimi Antonelli', 'Itália', 18, 'MER'),
  ('LEC', 'Charles Leclerc', 'Mônaco', 27, 'FER'),
  ('HAM', 'Lewis Hamilton', 'Reino Unido', 40, 'FER'),
  ('ALO', 'Fernando Alonso', 'Espanha', 43, 'AST'),
  ('STR', 'Lance Stroll', 'Canadá', 26, 'AST'),
  ('GAS', 'Pierre Gasly', 'França', 28, 'ALP'),
  ('COL', 'Franco Colapinto', 'Argentina', 21, 'ALP'),
  ('OCO', 'Esteban Ocon', 'França', 28, 'HAS'),
  ('BEA', 'Oliver Bearman', 'Reino Unido', 19, 'HAS'),
  ('ALB', 'Alex Albon', 'Reino Unido', 29, 'WIL'),
  ('SAI', 'Carlos Sainz', 'Espanha', 30, 'WIL'),
  ('HUL', 'Nico Hulkenberg', 'Alemanha', 37, 'SAU'),
  ('BOR', 'Gabriel Bortoleto', 'Brasil', 21, 'SAU'),
  ('LAW', 'Liam Lawson', 'Nova Zelândia', 21, 'RBL'),
  ('HAD', 'Isack Hadjar', 'França', 21, 'RBL');

INSERT INTO tb_grande_premio (gp_nome, dia_gp, data_gp, horario_gp, qtd_voltas, circuito_code, ano_temporada)
VALUES
 ('GP Monaco 2025', 'domingo', '2025-05-25', '13:00:00', 78, 'MON', 2025),
 ('GP Italia 2025', 'domingo', '2025-09-07', '13:00:00', 53, 'IMOL', 2025),
 ('GP Miami 2025', 'domingo', '2025-05-05', '13:30:00', 57, 'MIAM', 2025),
 ('GP Bélgica 2025', 'domingo', '2025-07-28', '13:00:00', 44, 'SPA', 2025);

INSERT INTO rl_classificacao_gp (gp_nome, piloto_code, posicao, tempo, pontuacao)
VALUES
('GP Italia 2025', 'VER', 1, '1:21:22', 25),
('GP Italia 2025', 'NOR', 2, '1:21:25', 18),
('GP Italia 2025', 'PIA', 3, '1:21:30', 15),
('GP Italia 2025', 'LEC', 4, '1:21:45', 12),
('GP Italia 2025', 'RUS', 5, '1:22:00', 10),
('GP Italia 2025', 'HAM', 6, '1:22:20', 8),
('GP Italia 2025', 'ALB', 7, '1:22:30', 6),
('GP Italia 2025', 'BOR', 8, '1:22:40', 4),
('GP Italia 2025', 'ANT', 9, '1:23:00', 2),
('GP Italia 2025', 'HAD', 10, '1:23:20', 1),
('GP Italia 2025', 'SAI', 11, '1:23:40', 0),
('GP Italia 2025', 'BEA', 12, '1:23:50', 0),
('GP Italia 2025', 'TSU', 13, '1:24:00', 0),
('GP Italia 2025', 'LAW', 14, '1:24:10', 0),
('GP Italia 2025', 'OCO', 15, 'Mais 1 volta', 0),
('GP Italia 2025', 'GAS', 16, 'Mais 1 volta', 0),
('GP Italia 2025', 'COL', 17, 'Mais 1 volta', 0),
('GP Italia 2025', 'STR', 18, 'Não Concluiu', 0),
('GP Italia 2025', 'ALO', 19, 'Não Concluiu', 0),
('GP Italia 2025', 'HUL', 20, 'Não Concluiu', 0); 

INSERT INTO rl_classificacao_piloto (ano_temporada, piloto_code, posicao, pontos, vitorias, podios)
VALUES
(2025, 'VER', 1, 25, 1, 1),
(2025, 'NOR', 2, 18, 0, 1),
(2025, 'PIA', 3, 15, 0, 1),
(2025, 'LEC', 4, 12, 0, 0),
(2025, 'RUS', 5, 10, 0, 0),
(2025, 'HAM', 6, 8, 0, 0),
(2025, 'ALB', 7, 6, 0, 0),
(2025, 'BOR', 8, 4, 0, 0),
(2025, 'ANT', 9, 2, 0, 0),
(2025, 'HAD', 10, 1, 0, 0),
(2025, 'SAI', 11, 0, 0, 0),
(2025, 'BEA', 12, 0, 0, 0),
(2025, 'TSU', 13, 0, 0, 0),
(2025, 'LAW', 14, 0, 0, 0),
(2025, 'OCO', 15, 0, 0, 0),
(2025, 'GAS', 16, 0, 0, 0),
(2025, 'COL', 17, 0, 0, 0),
(2025, 'STR', 18, 0, 0, 0),
(2025, 'ALO', 19, 0, 0, 0),
(2025, 'HUL', 20, 0, 0, 0);

INSERT INTO rl_classificacao_equipe (ano_temporada, equipe_code, posicao, pontos, vitorias, podios)
VALUES
 (2025, 'MCL', 1, 33, 0, 2),   
 (2025, 'RBR', 2, 25, 1, 1),
 (2025, 'FER', 3, 20, 0, 0),
 (2025, 'MER', 4, 12, 0, 0),
 (2025, 'WIL', 5, 6, 0, 0),
 (2025, 'SAU', 6, 4, 0, 0),
 (2025, 'RBL', 7, 1, 0, 0),
 (2025, 'HAS', 8, 0, 0, 0),   
 (2025, 'ALP', 9, 0, 0, 0),
 (2025, 'AST', 10, 0, 0, 0);  

INSERT INTO rl_grid_gp (treino_code, piloto_code, tempo)
VALUES
('TQ2', 'VER', '1:20:41'),
('TQ2', 'NOR', '1:20:44'),
('TQ2', 'LEC', '1:20:45'),
('TQ2', 'HAM', '1:20:48'),
('TQ2', 'ALO', '1:20:50'),
('TQ2', 'RUS', '1:20:59'),
('TQ2', 'PIA', '1:21:01'),
('TQ2', 'SAI', '1:21:12'),
('TQ2', 'ALB', '1:21:30'),
('TQ2', 'ANT', '1:21:48');


-- ============================================================
--                        SELECTS
-- ============================================================
USE formula_1;

-- Classificação geral de pilotos (temporada atual)
SELECT posicao, piloto_code, pontos, vitorias, podios
FROM rl_classificacao_piloto 
ORDER BY pontos DESC;

-- Resultados do GP Itália
SELECT gp.gp_nome 		AS 'Grande Prêmio', 
	   cl.posicao 		AS Posição,
	   p.nome 			AS Piloto, 
	   e.nome 			AS Equipe, 
       cl.tempo 		AS Tempo, 
	   cl.pontuacao 	AS Pontos
FROM rl_classificacao_gp cl
JOIN tb_piloto p 		ON cl.piloto_code = p.piloto_code
JOIN tb_grande_premio gp ON gp.gp_nome = cl.gp_nome
LEFT JOIN tb_equipe e	ON e.equipe_code = p.equipe_code
WHERE gp.gp_nome = 'GP Italia 2025'
ORDER BY cl.posicao;

-- Classificação geral de pilotos (detalhada)
SELECT rl.ano_temporada AS 'Temporada', 
	   rl.posicao 		AS 'Posição',
	   p.nome 			AS 'Piloto', 
	   e.nome 			AS 'Equipe', 
	   rl.pontos 		AS 'Pontos', 
	   rl.vitorias		AS 'Vitórias', 
	   rl.podios		AS 'Pódios'
FROM rl_classificacao_piloto rl
JOIN tb_piloto p 		ON p.piloto_code = rl.piloto_code
LEFT JOIN tb_equipe e	ON e.equipe_code = p.equipe_code
ORDER BY rl.posicao;

-- Classificação geral de equipes
SELECT rl.ano_temporada AS 'Temporada',
	   rl.posicao 		AS 'Posição',
	   e.nome 			AS 'Equipe',
	   rl.pontos 		AS 'Pontos',
	   rl.vitorias 		AS 'Vitórias',
	   rl.podios 		AS 'Pódios'
FROM rl_classificacao_equipe rl
JOIN tb_equipe e ON e.equipe_code = rl.equipe_code
ORDER BY rl.pontos DESC;

-- Quantidade de pilotos cadastrados
SELECT COUNT(*) AS 'Número de pilotos'
FROM tb_piloto;

-- Quantidade de circuitos cadastrados
SELECT COUNT(*) AS 'Quantidade de circuitos'
FROM tb_circuito;

-- Quantidade de pilotos britânicos
SELECT COUNT(*) AS 'Pilotos britânicos'
FROM tb_piloto
WHERE nacionalidade = 'Reino Unido';

-- Melhor tempo do grid
SELECT p.nome, gr.tempo
FROM rl_grid_gp gr
JOIN tb_piloto p ON p.piloto_code = gr.piloto_code
WHERE gr.tempo = (
    SELECT MIN(tempo)
    FROM rl_grid_gp
);

-- Piloto mais velho
SELECT nome, idade
FROM tb_piloto
WHERE idade = (SELECT MAX(idade) FROM tb_piloto);

-- Média de idade dos pilotos
SELECT ROUND(AVG(idade), 2) AS 'Média de idade'
FROM tb_piloto;

-- Piloto mais jovem
SELECT nome, idade
FROM tb_piloto
WHERE idade = (SELECT MIN(idade) FROM tb_piloto);

-- Equipes que começam com A ou M
SELECT nome
FROM tb_equipe
WHERE nome LIKE 'A%' OR nome LIKE 'M%'
ORDER BY nome;

-- Todos os pilotos e suas equipes
SELECT p.nome, p.nacionalidade, p.idade, e.nome AS equipe
FROM tb_piloto p
LEFT JOIN tb_equipe e ON e.equipe_code = p.equipe_code
ORDER BY e.nome;

-- Pilotos com mais de 10 pontos no GP Itália
SELECT gp.gp_nome, cl.posicao, p.nome AS piloto, e.nome AS equipe, cl.pontuacao AS pontos
FROM rl_classificacao_gp cl
JOIN tb_grande_premio gp ON gp.gp_nome = cl.gp_nome
JOIN tb_piloto p ON cl.piloto_code = p.piloto_code
LEFT JOIN tb_equipe e ON e.equipe_code = p.equipe_code
WHERE gp.gp_nome = 'GP Italia 2025'
  AND cl.pontuacao > 10
ORDER BY cl.pontuacao DESC;

-- Piloto com maior pontuação no GP Itália
SELECT gp.gp_nome AS 'Grande Prêmio', cl.posicao, p.nome AS Piloto, e.nome AS Equipe, cl.pontuacao AS Pontos
FROM rl_classificacao_gp cl
JOIN tb_piloto p ON cl.piloto_code = p.piloto_code
JOIN tb_grande_premio gp ON gp.gp_nome = cl.gp_nome
LEFT JOIN tb_equipe e ON e.equipe_code = p.equipe_code
WHERE gp.gp_nome = 'GP Italia 2025'
  AND cl.pontuacao = (
      SELECT MAX(pontuacao)
      FROM rl_classificacao_gp
      WHERE gp_nome = 'GP Italia 2025'
  );

-- Pilotos da Red Bull e soma dos pontos
SELECT 
    gp.gp_nome AS 'Grande Prêmio', 
    e.nome AS 'Equipe',
    GROUP_CONCAT(p.nome SEPARATOR ', ') AS 'Pilotos',
    SUM(cl.pontuacao) AS 'Pontos Totais'
FROM rl_classificacao_gp cl
JOIN tb_piloto p ON cl.piloto_code = p.piloto_code
JOIN tb_grande_premio gp ON gp.gp_nome = cl.gp_nome
LEFT JOIN tb_equipe e ON e.equipe_code = p.equipe_code
WHERE e.equipe_code = 'RBR'
GROUP BY gp.gp_nome, e.nome;


-- ============================================================
--                           VIEWS
-- ============================================================
-- View: Classificação geral de pilotos
CREATE OR REPLACE VIEW vw_classificacao_piloto AS
SELECT rl.ano_temporada AS 'Temporada', 
	   rl.posicao 		AS 'Posição',
	   p.nome 			AS 'Piloto', 
	   e.nome 			AS 'Equipe', 
	   rl.pontos 		AS 'Pontos', 
	   rl.vitorias		AS 'Vitórias', 
	   rl.podios		AS 'Pódios'
FROM rl_classificacao_piloto rl
JOIN tb_piloto p 		ON p.piloto_code = rl.piloto_code
LEFT JOIN tb_equipe e	ON e.equipe_code = p.equipe_code
ORDER BY rl.posicao;

SELECT * FROM vw_classificacao_piloto;

-- View: Classificação de equipes
CREATE OR REPLACE VIEW vw_classificacao_equipe AS
SELECT rl.ano_temporada AS 'Temporada',
	   rl.posicao 		AS 'Posição',
	   e.nome 			AS 'Equipe',
	   rl.pontos 		AS 'Pontos',
	   rl.vitorias 		AS 'Vitórias',
	   rl.podios 		AS 'Pódios'
FROM rl_classificacao_equipe rl
JOIN tb_equipe e ON e.equipe_code = rl.equipe_code
ORDER BY rl.pontos DESC;

SELECT * FROM vw_classificacao_equipe;

-- View: Resultados do GP Itália
CREATE OR REPLACE VIEW vw_gp_italia AS
SELECT gp.gp_nome 		AS 'Grande Prêmio', 
	   cl.posicao 		AS Posição,
	   p.nome 			AS Piloto, 
	   e.nome 			AS Equipe, 
       cl.tempo 		AS Tempo, 
	   cl.pontuacao 	AS Pontos
FROM rl_classificacao_gp cl
JOIN tb_piloto p 		ON cl.piloto_code = p.piloto_code
JOIN tb_grande_premio gp ON gp.gp_nome = cl.gp_nome
LEFT JOIN tb_equipe e	ON e.equipe_code = p.equipe_code
WHERE gp.gp_nome = 'GP Italia 2025'
ORDER BY cl.posicao;

SELECT * FROM vw_gp_italia;

-- =================================================================
--  TESTAR AUTOMATIZAÇÃO DAS PROCEDURES E TRIGGERS
-- =================================================================
--  Para ter uma vialização melhor crie as VIEWS: 
-- linha: 398 - vw_classificacao_pilotos;
-- linha: 414 - vw_classificacao_equipes;

SELECT * FROM vw_classificacao_piloto;
SELECT * FROM vw_classificacao_equipe;

-- ==============================================================
--                        PROCEDURES
-- ==============================================================

-- 1. Procedure para reordenar a posições da rl_classificacao_piloto
DELIMITER $$
DROP PROCEDURE IF EXISTS pr_reordena_classificacao_piloto $$
CREATE PROCEDURE pr_reordena_classificacao_piloto(IN temporada INT)
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_pos INT DEFAULT 1;
  DECLARE v_piloto_code VARCHAR(10);

  DECLARE piloto_cursor CURSOR FOR
    SELECT piloto_code
    FROM rl_classificacao_piloto
    WHERE ano_temporada = temporada
    ORDER BY pontos DESC, vitorias DESC, podios DESC;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN piloto_cursor;
  
  read_loop: LOOP
    FETCH piloto_cursor INTO v_piloto_code;
    IF done THEN
      LEAVE read_loop;
    END IF;
    UPDATE rl_classificacao_piloto
    SET posicao = v_pos
    WHERE piloto_code = v_piloto_code AND ano_temporada = temporada;
    SET v_pos = v_pos + 1;
  END LOOP;

  CLOSE piloto_cursor;
END $$
DELIMITER ;

-- 2. Procedure para reordenar a posições da rl_classificacao_equipe
DELIMITER $$
DROP PROCEDURE IF EXISTS pr_reordena_classificacao_equipe $$
CREATE PROCEDURE pr_reordena_classificacao_equipe(IN temporada INT)
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_pos INT DEFAULT 1;
  DECLARE v_equipe_code VARCHAR(10);

  DECLARE equipe_cursor CURSOR FOR
    SELECT equipe_code
    FROM rl_classificacao_equipe
    WHERE ano_temporada = temporada
    ORDER BY pontos DESC, vitorias DESC, podios DESC;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN equipe_cursor;

  read_loop: LOOP
    FETCH equipe_cursor INTO v_equipe_code;
    IF done THEN
      LEAVE read_loop;
    END IF;
    UPDATE rl_classificacao_equipe
    SET posicao = v_pos
    WHERE equipe_code = v_equipe_code AND ano_temporada = temporada;
    SET v_pos = v_pos + 1;
  END LOOP;

  CLOSE equipe_cursor;
END $$
DELIMITER ;

-- 3. Procedure para atualizar classificação de uma equipe (pontos, pódios, vitórias)
DELIMITER $$
DROP PROCEDURE IF EXISTS pr_atualiza_classificacao_equipe $$
CREATE PROCEDURE pr_atualiza_classificacao_equipe(equipe VARCHAR(3), temporada INT)
BEGIN
  DECLARE pontos_total INT;
  DECLARE vitorias_total INT;
  DECLARE podios_total INT;

  -- Buscar os valores agregados
  SELECT SUM(cl.pontuacao), 
         SUM(CASE WHEN cl.posicao = 1 THEN 1 ELSE 0 END), 
         SUM(CASE WHEN cl.posicao IN (1,2,3) THEN 1 ELSE 0 END)
    INTO pontos_total, vitorias_total, podios_total
  FROM rl_classificacao_gp cl
  JOIN tb_piloto p ON p.piloto_code = cl.piloto_code
  JOIN tb_grande_premio gp ON gp.gp_nome = cl.gp_nome
  WHERE p.equipe_code = equipe AND gp.ano_temporada = temporada;

  -- Atualizar a tabela de classificação de equipe
  UPDATE rl_classificacao_equipe
  SET pontos = IFNULL(pontos_total, 0),
      vitorias = IFNULL(vitorias_total, 0),
      podios = IFNULL(podios_total, 0)
  WHERE equipe_code = equipe AND ano_temporada = temporada;
END $$
DELIMITER ;


-- ==============================================================
--                          TRIGGERS
-- ==============================================================

-- 1. Trigger: Atualizar classificação da equipe após INSERT em rl_classificacao_gp
DELIMITER $$
DROP TRIGGER IF EXISTS tr_atualiza_classificacao_equipe $$
CREATE TRIGGER tr_atualiza_classificacao_equipe
AFTER INSERT ON rl_classificacao_gp
FOR EACH ROW
BEGIN
  DECLARE v_equipe VARCHAR(10);
  DECLARE v_temporada INT;

  -- Descobre equipe e temporada
  SELECT p.equipe_code, gp.ano_temporada
  INTO v_equipe, v_temporada
  FROM tb_piloto p
  JOIN tb_grande_premio gp ON gp.gp_nome = NEW.gp_nome
  WHERE p.piloto_code = NEW.piloto_code;

  -- Atualiza classificação da equipe
  CALL pr_atualiza_classificacao_equipe(v_equipe, v_temporada);

  -- Reordena as posições das equipes
  CALL pr_reordena_classificacao_equipe(v_temporada);
END $$
DELIMITER ;

-- 2. Trigger: Atualizar classificação do piloto após INSERT em rl_classificacao_gp
DELIMITER $$
DROP TRIGGER IF EXISTS tr_atualiza_classificacao_piloto $$
CREATE TRIGGER tr_atualiza_classificacao_piloto
AFTER INSERT ON rl_classificacao_gp
FOR EACH ROW
BEGIN
  DECLARE v_temporada INT;

  -- Descobre temporada do GP
  SELECT ano_temporada INTO v_temporada
  FROM tb_grande_premio
  WHERE gp_nome = NEW.gp_nome;

  -- Atualiza pontos
  UPDATE rl_classificacao_piloto
  SET pontos = pontos + NEW.pontuacao
  WHERE piloto_code = NEW.piloto_code AND ano_temporada = v_temporada;

  -- Se for vitória (1º), incrementa vitórias e pódios
  IF NEW.posicao = 1 THEN
    UPDATE rl_classificacao_piloto
    SET vitorias = vitorias + 1,
        podios = podios + 1
    WHERE piloto_code = NEW.piloto_code AND ano_temporada = v_temporada;
  -- Se for 2º ou 3º, apenas pódios
  ELSEIF NEW.posicao IN (2, 3) THEN
    UPDATE rl_classificacao_piloto
    SET podios = podios + 1
    WHERE piloto_code = NEW.piloto_code AND ano_temporada = v_temporada;
  END IF;

  -- Reordena as posições dos pilotos
  CALL pr_reordena_classificacao_piloto(v_temporada);
END $$
DELIMITER ;

-- =================================================================
-- Depois faça o insert e visualize o resultado;
-- =================================================================

-- INSERT INTO rl_classificacao_gp (gp_nome, piloto_code, posicao, tempo, pontuacao)
-- VALUES
-- ('GP Miami 2025', 'VER', 1, '1:32:10', 25),
-- ('GP Miami 2025', 'LEC', 2, '1:32:12', 18),
-- ('GP Miami 2025', 'HAM', 3, '1:32:15', 15),
-- ('GP Miami 2025', 'NOR', 4, '1:32:30', 12),
-- ('GP Miami 2025', 'RUS', 5, '1:32:50', 10),
-- ('GP Miami 2025', 'PIA', 6, '1:33:00', 8),
-- ('GP Miami 2025', 'SAI', 7, '1:33:10', 6),
-- ('GP Miami 2025', 'ALO', 8, '1:33:20', 4),
-- ('GP Miami 2025', 'ALB', 9, '1:33:30', 2),
-- ('GP Miami 2025', 'OCO', 10, '1:33:45', 1);

-- SELECT * FROM vw_classificacao_piloto;
-- SELECT * FROM vw_classificacao_equipe;


-- ============================================================
--                        FUNCTIONS
-- ============================================================

-- 1. Function para calcular total de pontos de uma equipe em uma temporada
DELIMITER $$
DROP FUNCTION IF EXISTS fn_pontos_equipe $$
CREATE FUNCTION fn_pontos_equipe (equipe VARCHAR(3), temporada INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT SUM(cl.pontuacao) INTO total
  FROM rl_classificacao_gp AS cl
  JOIN tb_piloto AS p ON p.piloto_code = cl.piloto_code
  JOIN tb_grande_premio AS gp ON gp.gp_nome = cl.gp_nome
  WHERE p.equipe_code = equipe AND gp.ano_temporada = temporada;
  
  RETURN IFNULL(total, 0);
END $$
DELIMITER ;

-- 2. Function para retornar o piloto mais velho
DELIMITER $$
DROP FUNCTION IF EXISTS fn_piloto_mais_velho $$
CREATE FUNCTION fn_piloto_mais_velho()
RETURNS VARCHAR(80)
DETERMINISTIC
BEGIN
  DECLARE nome_mais_velho VARCHAR(80);
  SELECT nome INTO nome_mais_velho
  FROM tb_piloto
  ORDER BY idade DESC
  LIMIT 1;
  
  RETURN nome_mais_velho;
END $$
DELIMITER ;
-- ============================================================
--                        FIM DO SCRIPT
-- ============================================================