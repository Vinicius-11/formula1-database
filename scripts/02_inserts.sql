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