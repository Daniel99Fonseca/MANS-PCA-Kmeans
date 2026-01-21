# Análise Não Supervisionada de Incidentes Rodoviários

**ISCTE**
**Métodos de Aprendizagem Não Supervisionada**
**2025/2026**

## Âmbito do Projeto

Este projeto tem como objetivo a aplicação de técnicas da UC ** Métodos de Aprendizagem Não Supervisionada** numa base de dados de incidentes rodoviários. 
O foco principal foi identificar padrões e segmentar os incidentes em perfis distintos, sem a utilização de uma variável-alvo pré-definida.

A análise permitiu transformar dados complexos de sinistros em informação acionável, identificando grupos de risco baseados em características financeiras, demográficas e contratuais.

## Trabalho realizado por:

| Nome | Número |
|------|--------|
| Daniel Fonseca | 125158 |
| Francisco Gonçalves | 130649 |
| João Filipe | 130665 |
| Guilherme Pires | 131658 |

## Metodologia

O fluxo de trabalho foi desenvolvido em **R** e consistiu nas seguintes etapas:

1.  **Pré-processamento de Dados:**
    * Limpeza de dados.
    * Seleção de variáveis.
    * Dimensão final da amostra: 907 observações e 24 variáveis.

2.  **Análise de Componentes Principais (PCA):**
    * **Seleção:** 2 Componentes retidas com base no *Scree Plot*.
    * **Dimensões Identificadas:**
        * *PC1 - Gravidade do Sinistro* (Severidade financeira e complexidade).
        * *PC2 - Maturidade do Cliente* (Idade e antiguidade).

3.  **Clustering (K-Means):**
    * Segmentação dos dados com base nos scores do PCA.
    * Identificação de 3 clusters distintos.

## Principais Resultados

A análise identificou três perfis principais de sinistralidade:

* **Grupo 1: Seniores Fidelizados de Alto Risco**
    * Clientes com longa relação contratual e idade avançada.
    * Envolvidos em colisões de alto custo e elevada taxa de "Perda Total".
    * Predominância do género feminino.

* **Grupo 2: Clientes de Baixo Risco (Incidentes Menores)**
    * Sinistros de baixo valor monetário.
    * Tipologias exclusivas: Roubo e acidentes em estacionamento.
    * Danos triviais.

* **Grupo 3: Jovens de Alto Risco**
    * Clientes mais jovens e com menor histórico na companhia.
    * Severidade financeira muito alta (similar aos Seniores), mas com menos casos catastróficos.
    * Foco em colisões multi-veículo.
