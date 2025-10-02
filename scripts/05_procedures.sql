-- ==============================================================
--                        PROCEDURES
-- ==============================================================

-- 1. Procedure para reordenar as posições da rl_classificacao_piloto
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

-- 2. Procedure para reordenar as posições da rl_classificacao_equipe
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