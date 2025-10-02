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