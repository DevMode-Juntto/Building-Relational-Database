# Building Relational Database — Checklist GS 2026/2

**Tema:** CitizenTech • **Ferramentas:** Oracle SQL Developer e Oracle Data Modeler • **Fonte:** PDF oficial, págs. **30–37** • **Entrega:** 19/11/2026, 23h55 • **Apresentação:** 23–27/11.

## Objetivo

Modelar e implementar **um banco relacional Oracle** da solução, com levantamento, modelos **conceitual, lógico e relacional**, dicionário de dados, script SQL, CRUD e consultas ligadas a perguntas reais do negócio.

## 1. Levantamento e modelagem

- [ ] Documentar **problema, público beneficiado, objetivo, atores, dados necessários, perguntas a responder e ODS** relacionados.
- [ ] Escrever levantamento **específico da solução**, não genérico.
- [ ] Criar **no mínimo 6 tabelas**, incluindo a associativa do N:N.
- [ ] Criar **pelo menos dois relacionamentos 1:N**.
- [ ] Criar **pelo menos um relacionamento N:N** com tabela associativa.
- [ ] Definir **PK em todas as tabelas** e **FK em todos os relacionamentos**.
- [ ] Demonstrar **modelo conceitual**, **modelo lógico** e **modelo relacional** no Oracle Data Modeler; são três artefatos distintos.
- [ ] Evitar atributos multivalorados e grupos repetidos; usar identificadores sem acentos e sem espaços.
- [ ] Criar **dicionário de dados**: tabela, coluna, tipo, tamanho, nulidade, chave, restrição e significado de cada coluna.

## 2. Implementação Oracle / SQL

- [ ] Criar tabelas com `CREATE TABLE`, respeitando a dependência das chaves estrangeiras.
- [ ] Incluir comentário em cada tabela.
- [ ] Implementar restrições **PK, FK, NOT NULL, UNIQUE e CHECK** (pelo menos uma de cada das três últimas, coerente com regras da solução).
- [ ] Popular **todas as tabelas**, com registros coerentes para demonstrar relacionamentos.
- [ ] Preparar **ao menos 60 registros no total** (pág. 31), observando divergência nos slides sobre 50 registros.
- [ ] Executar **pelo menos um `UPDATE ... WHERE ...`**.
- [ ] Executar **pelo menos um `DELETE ... WHERE ...`**. Sem `WHERE`, o item não é aceito.
- [ ] Capturar evidências de execução no Oracle (tabelas, INSERTs, consultas, UPDATE e DELETE).

## 3. Dez consultas SQL numeradas

Cada consulta deve responder **uma pergunta útil para a solução CitizenTech**. O conjunto precisa apresentar:

- [ ] **10 consultas numeradas**, com enunciado da pergunta que cada uma responde.
- [ ] `WHERE`.
- [ ] `ORDER BY`.
- [ ] **Cálculo explícito no `SELECT`** (não basta usar apenas agregação).
- [ ] `COUNT`.
- [ ] `SUM`.
- [ ] `AVG`.
- [ ] `MAX`.
- [ ] `MIN`.
- [ ] `GROUP BY` nas consultas de agregação pertinentes.
- [ ] Pelo menos **uma consulta com `HAVING`**.
- [ ] Pelo menos **uma subconsulta** (`SUBSELECT`).
- [ ] Pelo menos **uma `INNER JOIN`**.
- [ ] Pelo menos **uma `LEFT JOIN`**.
- [ ] Pelo menos **uma `RIGHT JOIN`**.

> Uma consulta pode contemplar vários recursos; não é necessário criar uma consulta exclusiva para cada comando.

## Pontuação do material de entrega — rubrica de 100 pontos (peso de 70%)

| Item | Pontos |
|---|---:|
| Levantamento de requisitos, dados, perguntas e ODS | 10 |
| DER / conceitual: entidades, atributos, relacionamentos e cardinalidades | 10 |
| Dicionário, lógico e relacional; chaves e associativa | 15 |
| SQL Oracle: tabelas, PK, FK, NOT NULL, UNIQUE e CHECK | 15 |
| CRUD: 50 registros nas tabelas, UPDATE e DELETE com WHERE | 15 |
| Consultas SQL: filtro, cálculo, agregação, HAVING e subconsulta | 15 |
| Junções: INNER, LEFT e RIGHT JOIN | 15 |
| Organização de PDF/SQL, três modelos, prints e consultas numeradas | 5 |
| **Total** | **100** |

## Entregáveis

- [ ] **PDF** contendo levantamento, os três modelos do Data Modeler, dicionário de dados e enunciados das dez consultas.
- [ ] **SQL** com a sequência solicitada: `CREATE TABLE` → `INSERTs` → 10 consultas numeradas → `UPDATE` → `DELETE`.
- [ ] **Capturas de tela** de execução Oracle (preferencialmente incorporadas ao PDF, dada a divergência abaixo).
- [ ] Capa do PDF com **nomes, RMs e turma**.
- [ ] Compactar no formato exigido e abrir o arquivo para conferir integridade.

### Atenção: divergências do próprio edital

1. **Quantidade de registros:** página **31** pede **60 registros no total**; páginas **30, 34 e 37** citam **50 registros** ou 50 INSERTs. Opção conservadora: implementar **60 ou mais** sem deixar tabela vazia; confirmar com o professor.
2. **ZIP e capturas:** página **37** pede prints de execução, mas também descreve o ZIP como “somente com o PDF e o `.sql`”. Para contemplar os dois trechos, inserir os prints **dentro do PDF** e confirmar se são exigidos separadamente.
3. **Identificação:** a regra geral da pág. 15 menciona `.txt` em cada `.zip`, enquanto esta disciplina especifica capa e PDF/SQL. Confirmar com o professor antes de fechar o ZIP.

## Apresentação presencial — rubrica de 100 pontos (peso de 30%)

- [ ] **15 pts:** problema, público e papel do banco.
- [ ] **15 pts:** modelos conceitual, lógico, relacional e dicionário de dados.
- [ ] **15 pts:** criar/executar tabelas no Oracle.
- [ ] **15 pts:** demonstrar INSERT, UPDATE e DELETE.
- [ ] **20 pts:** demonstrar filtro, agregação e subconsulta.
- [ ] **20 pts:** mostrar INNER/LEFT/RIGHT JOIN e responder perguntas de qualquer integrante.

## Penalidades / riscos

- **Nota zero:** envio fora do prazo ou fora do Portal do Aluno.
- **Item zerado:** arquivo ausente, incompleto ou corrompido.
- **Até −50 pts:** solução não relacionada à CitizenTech.
- **Até −10 pts por consulta:** consulta incompleta ou que não executa.
- **Até −10 pts por ausência:** modelo conceitual, lógico ou dicionário não entregues.

_Fonte: Global Solution 2026/2 — Building Relational Database, págs. 30–37._
