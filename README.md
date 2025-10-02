# 🏎️ Formula 1 - Banco de Dados SQL (Temporada 2025)

Projeto completo de banco de dados relacional inspirado na temporada de Fórmula 1 de 2025. Desenvolvido em MySQL com foco em aprendizado, portfólio e boas práticas de modelagem e SQL avançado.

---

## 📌 Sobre o Projeto

Este repositório contém a modelagem e implementação de um banco de dados relacional que simula a gestão da Fórmula 1 em sua temporada 2025.  
Inclui desde o cadastro de pilotos, equipes, circuitos e GPs até classificações, resultados de treinos, pontuações e estatísticas detalhadas.

---

## 🧱 Estrutura do Projeto

```shell
📦 formula1-database/
├── 📁 docs/
│   └── modelo.relacional.png          # Imagem do Modelo Entidade-Relacionamento (ER) 
│
├── 📁 scripts/
│   ├── 01_create_tables.sql           # Criação de tabelas (DDL)
│   ├── 02_inserts.sql                 # Inserção de dados (DML)
│   ├── 03_selects.sql                 # Consultas SQL (SELECTs principais)
│   ├── 04_views.sql                   # Criação de Views
│   ├── 05_procedures.sql              # Criação de Procedures
│   ├── 06_triggers.sql                # Criação de Triggers
│   └── 07_functions.sql               # Criação de Functions
│
├── formula1-script.sql                # Script completo
└── README.md                          # Arquivo de documentação do projeto
```

---

## ▶️ Como Executar

1. Importe o arquivo `formula1-script.sql` em seu SGBD (MySQL 8+ recomendado).
2. Execute os scripts em ordem (01 → 06) para garantir a criação correta de tabelas, dados, views, procedures, triggers e functions.
3. Utilize os scripts da pasta `scripts/` para testar funcionalidades separadamente.
4. Visualize os resultados por meio das `views` disponíveis ou utilizando comandos `SELECT`.

> 💡 Dica: Use ferramentas como MySQL Workbench ou DBeaver para melhor visualização.

---

## ⚙️ Funcionalidades SQL

### 🔹 Tabelas do Banco de Dados
- `tb_formula1` – Temporadas da Fórmula 1
- `tb_circuito` – Circuitos de corrida
- `tb_equipe` – Equipes participantes
- `tb_piloto` – Pilotos cadastrados
- `tb_treino` – Sessões de treino
- `tb_grande_premio` – Grandes Prêmios (GPs)
- `rl_classificacao_gp` – Classificação de pilotos por GP
- `rl_classificacao_equipe` – Classificação geral por equipe
- `rl_classificacao_piloto` – Classificação geral por piloto
- `rl_grid_gp` – Grid de largada baseado nos treinos

### 🔹 Selects
- Classificações atualizadas
- Consultas estatísticas (idades, pontuações, médias)
- Pilotos por nacionalidade e equipe
- Melhor tempo de treino, etc.

### 🔹 Views
- `vw_classificacao_pilotos`
- `vw_classificacao_equipes`
- `vw_gp_italia`

### 🔹 Stored Procedures
- `pr_reordena_classificacao_piloto`: Reorganiza a tabela rl_classificacao_piloto de acordo com os critérios de pontuação, número de vitórias e pódios, atualizando as posições dos pilotos na temporada informada.

- `pr_reordena_classificacao_equipe`: Reorganiza a tabela rl_classificacao_equipe conforme os pontos, vitórias e pódios, atualizando as posições das equipes.

- `pr_atualiza_classificacao_equipe`: Atualiza os valores agregados de pontos, vitórias e pódios de uma equipe específica com base nos resultados de GPs da temporada indicada.

### 🔹 Triggers
- `tr_atualiza_classificacao_equipe`: Trigger que atualiza automaticamente os pontos, vitórias e pódios da tabela rl_classificacao_equipe sempre que um novo resultado de corrida é inserido em rl_classificacao_gp. Também reordena as posições com base nos critérios definidos.

- `tr_atualiza_classificacao_piloto`: Trigger responsável por atualizar os pontos, vitórias e pódios de um piloto na tabela rl_classificacao_piloto após um novo resultado de corrida. Reorganiza automaticamente a classificação geral dos pilotos.

### 🔹 Functions
- `fn_pontos_equipe`: Retorna o total de pontos acumulados por uma equipe em uma determinada temporada, considerando todos os resultados registrados em rl_classificacao_gp.

- `fn_piloto_mais_velho`: Retorna o piloto mais velho presente na tabela tb_piloto, com base no campo de idade.

---