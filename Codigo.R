#install.packages("readr")
#install.packages("corrplot")
#install.packages("dplyr")
#install.packages("psych")
#install.packages("xlsx")
#install.packages("ggplot2")
#install.packages("corrplot")
library(readr)
library(dplyr)
library(psych)
library(xlsx)
library(corrplot)
library(ggplot2)
library(corrplot)

base_dados <- read_csv("dados_acidentes.csv")

# Filtro da base de dados para o grupo PLGR08
dadosg8 <- base_dados %>% 
  filter(PLGR08 == 1) %>% 
  select(-starts_with("PLGR"), -starts_with("T1GR"), -starts_with("T2GR"))

# Primeiras linhas
head(dadosg8)

# Verificação do tipo de dados
str(dadosg8)

# Substituir "?" por NA
dadosg8 <- dadosg8 %>%
  mutate(across(where(is.character), ~na_if(., "?")))

sum(is.na(dadosg8))

# Ver quantidade de NAs por coluna -> é só em colunas de texto
colSums(is.na(dadosg8))

# Criar um DF só com variáveis numéricas para o PCA
dados_pca <- dadosg8 %>%
  select(where(is.numeric), -total_claim_amount)

colnames(dados_pca)

# Matriz de correlação
matriz_cor <- cor(dados_pca)
corrplot(matriz_cor)

describe(dados_pca)

set.seed(123) # É preciso uma seed para o fa.parallel dar sempre os mesmos 
              # resultados
resultado_parallel <- fa.parallel(dados_pca, 
                                  fa = "pc", 
                                  ylabel = "Eigenvalues",
                                  show.legend = TRUE,
                                  main = "Scree Plot com Análise Paralela")

# Executar PCA 
pca <- principal(dados_pca,
                 nfactors = 2, 
                 rotate = "none", 
                 scores = TRUE)

# Ver os resultados
print(pca, digits = 2, cut = 0.3)

# gráfico vazio
plot(pca$loadings, 
     type = "n", 
     xlim = c(-1, 1.2),
     ylim = c(-1, 1),
     main = "Mapa das Variáveis (PC1 vs PC2)",
     xlab = "PC1: Custo",
     ylab = "PC2: Idade")

# Linhas de referência e pontos vermelhos
abline(h = 0, v = 0, col = "grey", lty = 2)
points(pca$loadings, pch = 19, col = "red")

# Escrever os nomes c posiçoes alternadas
text(pca$loadings, 
     labels = rownames(pca$loadings),
     cex = 0.8,              #
     pos = c(3, 1, 4, 2),    # 3=Cima, 1=Baixo, 4=Direita, 2=Esquerda
     col = "blue")

# -------------- CLUSTERING ----------------------

# Clientes à direita: Tiveram acidentes muito caros.
# Clientes em cima: São clientes antigos/velhos.
# Gráfico de dispersão dos Scores
plot(pca$scores, 
     main = "Distribuição dos Clientes (Scores)",
     xlab = "PC1: Gravidade do Sinistro (Custo)", 
     ylab = "PC2: Maturidade do Cliente (Idade)",
     pch = 20,
     col = "grey50",
     xlim = c(-3, 5))    # Ajuste limites

# Adicionar linhas
abline(h = 0, v = 0, col = "red", lty = 2)

# Adicionar legendas
text(x = 3, y = 0, labels = "SINISTROS\nGRAVES", col = "red", font = 2)
text(x = -1.5, y = 2, labels = "CLIENTES\nMADUROS", col = "blue", font = 2)
text(x = -1.5, y = -2, labels = "CLIENTES\nNOVOS", col = "green4", font = 2)

# Junção dos dados
scores <- as.data.frame(pca$scores)
dados_final <- cbind(dadosg8, scores) # Juntar dados originais + PC1/PC2

# K-Means com 3 Grupos
k3 <- kmeans(scores, centers = 3, nstart = 25)
dados_final$cluster <- as.factor(k3$cluster)

# Visualização
ggplot(dados_final, aes(x = PC1, y = PC2, color = cluster)) +
  geom_point(alpha = 0.6, size = 2) +
  labs(title = "Segmentação de Clientes (3 Clusters)",
       x = "PC1: Custo / Gravidade",
       y = "PC2: Maturidade / Idade",
       color = "Grupo") +
  theme_minimal() +
  geom_vline(xintercept = 0, linetype="dashed") +
  geom_hline(yintercept = 0, linetype="dashed")

# Calculo das médias por Cluster
resumo <- aggregate(cbind(total_claim_amount, age, months_as_customer) ~ cluster, 
                    data = dados_final, 
                    FUN = mean)

# Arredondamentos
resumo$total_claim_amount <- round(resumo$total_claim_amount, 0)
resumo$age <- round(resumo$age, 1)
resumo$months_as_customer <- round(resumo$months_as_customer, 1)

print(resumo)

# 1. Tipo de Incidente por Cluster (Quem bateu e quem foi roubado?)
tipo_incidente <- cbind(table(dados_final$cluster, dados_final$incident_type))

# 2. Gravidade do Incidente
gravidade_incidente <- cbind(table(dados_final$cluster, dados_final$incident_severity))

# 3. Sexo (Será que um grupo tem mais homens/mulheres?)
sexo <- cbind(table(dados_final$cluster, dados_final$insured_sex))
