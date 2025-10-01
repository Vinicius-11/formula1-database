-- ============================================================
--                        SELECTS
-- ============================================================
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