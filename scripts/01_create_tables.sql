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