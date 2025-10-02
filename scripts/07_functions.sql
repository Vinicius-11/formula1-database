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