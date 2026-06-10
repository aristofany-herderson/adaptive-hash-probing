# Avaliacao experimental de sondagem linear em tabelas hash

Trabalho experimental para **IMD0029 - Estrutura de Dados Basicas I** (UFRN/BTI), comparando estrategias de tratamento de colisoes por sondagem linear.

## Estrategias implementadas

| Estrategia | Referencia | Ideia central |
|---|---|---|
| `LinearProbing` | Baseline classico | Uma funcao hash, sondagem linear ciclica |
| `LocallyLinear` | Dalal, Devroye & Malalla (2023) | Dois blocos candidatos; sondagem linear **dentro** do bloco menos carregado |
| `WalkFirst` | Dalal, Devroye & Malalla (2023) | Duas sequencias lineares ate celulas terminais; escolhe a do bloco menos carregado |
| `AdaptiveLocal` | Contribuicao propria (inspirada no Bathroom Model) | Usa LP enquanto cluster local e baixo; aciona two-way ao detectar saturacao local |

## Contribuicao experimental

A heuristica **AdaptiveLocal** nao e apresentada como algoritmo teorico novo. Ela implementa uma regra local simples:

1. Mede o cluster forward a partir da celula inicial `h1(k)`.
2. Mede a ocupacao do bloco correspondente.
3. Se `cluster < limiar` (padrao: 8) **e** ocupacao do bloco `< 85%`, insere com LP classico.
4. Caso contrario, usa insercao estilo WalkFirst (duas sondagens + bloco menos carregado).

Isso permite discutir, nos graficos, **em que faixa de carga a adaptacao ajuda** e **onde degrada** (esperado perto de alpha = 0.95).

## Compilacao e execucao

Requisitos: `g++` (C++14), Python 3 + pandas + matplotlib para graficos.

```bash
make
make run
make plot
```

Execucao rapida (tabela menor, menos repeticoes):

```bash
make quick
```

Parametros do benchmark:

```bash
build/benchmark.exe --table-size 65536 --repetitions 50 --seed 42 --output results
```

## Saidas

- `results/benchmark_raw.csv` — uma linha por (estrategia, alpha, repeticao)
- `results/benchmark_summary.csv` — medias agregadas
- `results/plots/*.png` — graficos para o artigo

## Metricas coletadas

- Media de sondas por insercao e por busca (sucesso/falha)
- Maior cluster na tabela
- Pior caso de sondas (insercao e busca)
- Tempo de execucao (ms)
- Memoria auxiliar (contadores por bloco)

## Referencias

- Dalal, R.; Devroye, L.; Malalla, E. **Two-Way Linear Probing Revisited**. *Algorithms*, 2023.
- Bathroom Model (inspiracao conceitual para adaptacao dinamica).

## Estrutura

```
include/
  hash_table.hpp      # interface comum
  hash_utils.hpp      # hash e utilitarios de bloco
  metrics.hpp         # metricas e cluster maximo
  strategies.hpp      # LP, LocallyLinear, WalkFirst, AdaptiveLocal
src/
  benchmark.cpp       # driver experimental
scripts/
  plot_results.py     # graficos
```
