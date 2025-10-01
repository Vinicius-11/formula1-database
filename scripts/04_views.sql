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