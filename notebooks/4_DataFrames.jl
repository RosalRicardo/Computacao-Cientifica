### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 27f62732-c909-11eb-27ee-e373dce148d9
begin
	using Pkg
	using PlutoUI
	
	using BenchmarkTools
	using CSV
	using CategoricalArrays
	using DataFrames
	using HTTP
	using XLSX
	using Statistics: mean, std, cor
end

# ╔═╡ 228e9bf1-cfd8-4285-8b68-43762e1ae8c7
begin
	using InteractiveUtils
	with_terminal() do
		versioninfo()
	end
end

# ╔═╡ cbc48ca5-f1a4-4e13-9323-2fd2c43d8612
TableOfContents(aside=true)

# ╔═╡ 7bb67403-d2ac-4dc9-b2f1-fdea7a795329
md"""
# Dados Tabulares com [`DataFrames.jl`](https://github.com/JuliaData/DataFrames.jl)
"""

# ╔═╡ a20561ca-2f63-4ff4-8cff-5f93da0e940c
Resource("https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg", :width => 120, :display => "inline")

# ╔═╡ 98ddb212-89ff-4376-8103-fb6c9518d0f7
md"""
!!! info "💁 Dados Tabulares"
    Vamos gastar **muito tempo** com Dados Tabulares. É uma coisa **muito importante**.
"""

# ╔═╡ f8557972-abb6-4fc1-9007-8d6fb91ca184
Resource("https://github.com/storopoli/Computacao-Cientifica/blob/master/images/data-everywhere.png?raw=true", :width => 600)

# ╔═╡ b22870c8-fc29-451d-afcf-4e07823291fc
md"""
## Dados Tabulares

Quase tudo que mexemos que envolvem dados fazemos por meio de dados tabulares.

Onde:

* Cada **coluna** é uma variável
* Cada **linha** é uma observação
* Cada **célula** é uma mensuração única
"""

# ╔═╡ 0bdad8c0-837c-4814-a8d9-e73bec34399e
md"""
$(Resource("https://github.com/storopoli/Computacao-Cientifica/blob/master/images/tidydata_1.jpg?raw=true"))

> Figura com licença creative commons de [`@allisonhorst`](https://github.com/allisonhorst/stats-illustrations)
"""

# ╔═╡ 0553799f-c084-4f24-85c4-6da4c26cf524
md"""
## Datasets Utilizados

* `palmerpenguins`
* `starwars`
"""

# ╔═╡ 4722d7bc-789f-4c4b-966f-483fd276a243
md"""
### Dataset `palmerpenguins`

É um dataset aberto sobre pinguins que foram encontrados próximos da estação de Palmer na Antártica.

344 penguins e 8 variáveis:

- `species`: uma das três espécies (Adélie, Chinstrap ou Gentoo)
- `island`: uma das ilhas no arquipélago Palmer na Antartica (Biscoe, Dream ou Torgersen)
- `bill_length_mm`: comprimento do bico em milímetros
- `bill_depth_mm`: altura do bico em milímetros
- `flipper_length_mm`: largura da asa em milímetros
- `body_mass_g`: massa corporal em gramas
- `sex`: sexo (female ou male)

Ele está na minha pasta `data/` tanto como `penguins.csv` como `penguins.xlsx`

> Dataset com licença creative commons de [`allisonhorst/palmerpenguins`](https://github.com/allisonhorst/palmerpenguins).
"""

# ╔═╡ 99c0cc2a-b538-4b42-8a6e-ddf4d93c5baa
md"""
$(Resource("https://github.com/storopoli/Computacao-Cientifica/blob/master/images/palmerpenguins_1.png?raw=true", :width => 338))
$(Resource("https://github.com/storopoli/Computacao-Cientifica/blob/master/images/palmerpenguins_2.png?raw=true", :width => 338))
"""

# ╔═╡ edeabce5-2296-4eb5-9410-cdb9b6187e7e
md"""
### Dataset `starwars`

87 personagens e 14 variáveis:

- `name`: nome do personagem
- `height`: altura em cm
- `mass`: peso em kg
- `hair_color`, `skin_color` ,`eye_color`: cor de cabelo, pele e olhos
- `birth_year`: ano de nascimento em BBY (BBY = Before Battle of Yavin)
- `sex`: o sexo biológico do personagem, `male`, `female`, `hermaphroditic`, ou `none` (no caso de Droids)
- `gender`: a identidade de gênero do personagem determinada pela sua personalidade ou pela maneira que foram programados (no caso de Droids)oids).
- `homeworld`: nome do mundo de origem
- `species`: nome da espécie
- `films`: lista de filmes que o personagem apareceu
- `vehicles`: lista de veículos que o personagem pilotou
- `starships`: lista de naves que o personagem pilotou

> Dataset obtido por licença creative commons do StarWars API `https://swapi.dev/`
"""

# ╔═╡ c390de55-1f7c-4278-9d99-fd75c94f5e9d
md"""
!!! tip "💡 Julia"
    Provavelmente Julia faz o percurso de Kessel em bem menos que 12 parsecs.
"""

# ╔═╡ 9197ec1a-eb2b-4dea-bb96-5ff16a9c423f
Resource("https://github.com/storopoli/Computacao-Cientifica/blob/master/images/12-parsecs.gif?raw=true", :width => 800)

# ╔═╡ f5f02b1c-0734-4e00-8b78-fab0ef6ab6c2
md"""
# Dados Tabulares em Julia

Não tem muito o que pensar...
"""

# ╔═╡ 750df153-fb1c-4b65-bc17-6d408000e422
Resource("https://github.com/storopoli/Computacao-Cientifica/blob/master/images/dataframes.jpg?raw=true", :width => 600)

# ╔═╡ e4f7f01e-76bb-4f26-b231-0a01d817fc33
md"""
```julia
using DataFrames
```

Um exemplo para mostrar algumas coisas adiante:
"""

# ╔═╡ 7a47a8d3-0408-4e8a-bcd9-ffaf696eae81
df_1 = DataFrame(x_1=rand(5), x_2=rand(5), x_3=rand(5), y_a=rand(5), y_b=rand(5))

# ╔═╡ 4f8b256e-9069-4d23-bf9e-a95867ffe3da
typeof(df_1)

# ╔═╡ a6b81169-b0cf-49e6-a700-d3618d7aeae9
md"""
# Informações sobre um `DataFrame`

- `size(df)`: tupla das dimensões (similar ao `df.shape` de Python)
- `nrow(df)` e `ncol(df)`: número de linhas e número de colunas
- `first(df, 5)` e `last(df, 5)`: 5 primeiras ou últimas linhas com o *header*
- `describe(df)`: similar ao `df.describe()` de Pandas
- `names(df)`: vetor de colunas como `String`s
- `propertynames(df)`: vetor de colunas como `Symbol`s
- `hasproperty(df, :x1)`: retorna um `Bool` se a coluna `x1` ∈ `df`
- `columnindex(df, :x2)`: returna o `index` da coluna `x2` ∈ `df`
- `colwise(sum, df)`: operações *column-wise*
- `df2 = copy(df)`: copia um DataFrame
"""

# ╔═╡ 50af3d7c-535d-42fc-8fc5-d124210055e5
size(df_1)

# ╔═╡ 06a37ad8-2ff7-4999-9008-98aa96b73420
first(df_1, 3)

# ╔═╡ 5da74073-e6cd-4ce9-a994-797be0e59ff8
ncol(df_1)

# ╔═╡ 843ac012-f8f1-4655-84e2-ffb151b99bea
names(df_1)

# ╔═╡ c4efdf84-8700-4ed9-b40a-965d9188ffbc
md"""
## Estatísticas Descritivas com o `describe`
"""

# ╔═╡ de547f28-1eb5-4438-b088-adbeae032f55
md"""
!!! tip "💡 describe(df)"
    Por padrão `describe(df)` é `describe(df, :mean, :min, :median, :max, :nmissing, :eltype)`. 
"""

# ╔═╡ 877c0807-b9a9-406c-ac5d-dd7478a197c6
describe(df_1)

# ╔═╡ 7f223d58-4bd1-4b3d-9c14-9d84d0b8e7dd
md"""
Mas você pode escolher o que você quiser:

- `:mean`: média
- `:std`: desvio padrão
- `:min`: mínimo
- `:q25`: quartil 25
- `:median`: mediana
- `:q75`: quartil 75
- `:max`: máximo
- `:nunique`: número de valores únicos
- `:nmissing`: número de valores faltantes
- `:first`: primeiro valor
- `:last`: último valor
- `:eltype`: tipo de elemento (e.g. `Float64`, `Int64`, `String`)
"""

# ╔═╡ d73508d0-649c-46c5-be35-fc0ae7990ee3
describe(df_1, :mean, :median, :std)

# ╔═╡ 77d83116-8d87-4313-aaaf-e57d0322c3fe
md"""
Ou até inventar a sua função de sumarização:
"""

# ╔═╡ 39a3b34d-2cb5-4033-a243-c13af0a49b2c
describe(df_1, sum => :sum)

# ╔═╡ 8d4c63fe-2c4c-40d4-b079-7a4fd2b55142
md"""
Por padrão `describe` age em todas as colunas do dataset. Mas você pode definir um subconjunto de colunas com o argumento `cols`:
"""

# ╔═╡ ae553b32-49a0-4c45-950b-bb4400e069ae
describe(df_1, :mean; cols=[:x_1, :x_2])

# ╔═╡ 8959d49d-b019-442d-adb6-99c1450ec108
md"""
# *Input*/*Output* (IO)

1. [`CSV.jl`](https://github.com/JuliaData/CSV.jl): para ler qualquer arquivo delimitado -- `.csv`, `.tsv` etc.
2. [`XLSX.jl`](https://github.com/felipenoris/XLSX.jl): para ler arquivos Excel `.xslx` e `.xls`.
3. [`JSONTables.jl`](https://github.com/JuliaData/JSONTables.jl): para ler arquivos JSON `.json`.
4. [`Arrow.jl`](https://github.com/JuliaData/Arrow.jl): formato Apache Arrow para Big Data (que não cabe na RAM).
5. [`JuliaDB.jl`](https://juliadb.org/): leitura e manipulação de Big Data (que não cabe na RAM).
6. **Banco de Dados**: Julia também trabalha bem com banco de dados. Veja [juliadatabases.org](https://juliadatabases.org/)
"""

# ╔═╡ bd0fdeff-13c8-445e-86fc-bd619bd37645
md"""
## `CSV.jl`
"""

# ╔═╡ 811b2abe-a7ff-4985-a4a2-2b03301dc099
md"""
Óbvio que você já deve estar cansado disso, mas [Julia é mais rápida que R ou Python em leitura de CSVs](https://juliacomputing.com/blog/2020/06/fast-csv/):
"""

# ╔═╡ 07e01ad7-2f1c-45fd-88aa-a7e5e528fd52
Resource("https://github.com/storopoli/Computacao-Cientifica/blob/master/images/fast_csv_heterogeneous.png?raw=true")

# ╔═╡ ba30be06-4c47-4e13-a263-2d3b77e78802
md"""
> Este dataset possui 10 mil linhas e 200 colunas. As colunas contêm `String`, `Float`, `DateTime` e `missing`. O Pandas leva cerca de 400 milissegundos para carregar este dataset. Sem multithreading, `CSV.jl` é 2 vezes mais rápido que R e cerca de 10 vezes mais rápido com 10 threads.

> Fonte: [Julia Computing em 2020](https://juliacomputing.com/blog/2020/06/fast-csv/).
"""

# ╔═╡ 68e791a3-cfff-4115-8cbe-b7cc40b67bc4
md"""
!!! tip "💡 Opções CSV.jl"
    `CSV.jl` tolera qualquer maluquice que vier pela frente de arquivo delimitado. Veja a documentação para a função [`CSV.File`](https://csv.juliadata.org/dev/#CSV.File).
"""

# ╔═╡ 75984809-48aa-4c14-a193-23695831c1b7
md"""
Tem várias maneiras de ler `.csv`s:

- Vanilla: `CSV.File(file) |> DataFrame` ou `CSV.read(file, DataFrame)`
- Brasileiro/Europeu: `CSV.read(file, DataFrame; delim=";")`
- Lendo da internet:
  ```julia
  using HTTP
  url = "..."
  CSV.read(HTTP.get(url).body, DataFrame)
  ```
- Lendo uma porrada de CSV de um diretório:
   - preservando a ordem:
     ```julia
     files = filter(endswith(".csv"), readdir())
     reduce(vcat, CSV.read(file, DataFrame) for file in files)
     ```
   - não preservando a ordem (mais rápido):
     ```julia
     files = filter(endswith(".csv"), readdir())
     mapreduce(x -> CSV.read(x, DataFrame), vcat, files)
     ```
- Lendo arquivos comprimidos:
   - Gzip:
     ```julia
     using CodecZlib, Mmap
     CSV.File(transcode(GzipDecompressor, Mmap.mmap("a.csv.gz"))) |> DataFrame
     ```
   - Zip:
     ```julia
     using ZipFile
     z = ZipFile.Reader("a.zip") # or "a2.zip"
     # identificar o arquivo correto no zip
     a_file_in_zip = filter(x->x.name == "a.csv", z.files)[1]
     CSV.File(read(a_file_in_zip)) |> DataFrame
     ```
- Lendo CSV em pedaços (*chunks*): `CSV.Chunks(source; tasks::Integer=Threads.nthreads(), kwargs...)`
- Lendo CSV de uma `String`:
  ```julia
  minha_string = "..."
  CSV.read(IOBuffer(contents), DataFrame)
  ```
"""

# ╔═╡ 456acc71-3199-481c-b37c-0041ddb18a11
md"""
!!! tip "💡 Escrevendo CSV"
    Só usar o `CSV.write`:

	`CSV.write(file, table; kwargs...) => file`

    `df |> CSV.write(file; kwargs...) => file`
"""

# ╔═╡ dd760bda-855b-41a0-bc59-be46943c5705
md"""
### `CSV.File` vs `CSV.read`

`CSV.File` materializa um arquivo `.csv` como um `DataFrame` **copiando as colunas** da função `CSV.File`:

```julia
df = CSV.File(file) |> DataFrame
```

`CSV.read` **evita fazer cópias das colunas** do arquivo `.csv` parseado

```julia
df = CSV.read(file, DataFrame)
```
"""

# ╔═╡ 0224e6af-4b4b-45d8-b7a2-3a8152638b6a
md"""
Para arquivos pequenos a diferença não é impactante. Mas para arquivos grandes eu recomendo `CSV.read`. Aliás eu só uso essa função.
"""

# ╔═╡ b4ed9851-3c64-4d10-8160-5d2e90681e72
penguins_file = joinpath(pwd(), "..", "data", "penguins.csv")

# ╔═╡ 04b9e718-44a5-4e4d-9d4a-10b72a140e3c
@benchmark CSV.File(penguins_file) |> DataFrame

# ╔═╡ 6c7e84cd-0747-4291-ace4-e1b0fa079c97
@benchmark CSV.read(penguins_file, DataFrame)

# ╔═╡ f6d41644-3d13-4d4a-b8b8-c3fc9abec689
penguins = CSV.read(penguins_file, DataFrame; missingstring="NA")

# ╔═╡ fafdd689-6c1f-4036-aeb8-47c75cc73e9f
begin
	url = "https://github.com/tidyverse/dplyr/blob/master/data-raw/starwars.csv?raw=true"
	starwars = CSV.read(HTTP.get(url).body, DataFrame; missingstring="NA")
end

# ╔═╡ ca69e258-32eb-479f-ab67-8d6969dc77ce
md"""
## XLSX.jl
"""

# ╔═╡ 0f601a7e-8b3c-4807-82cd-38cd448395b9
Resource("https://github.com/storopoli/Computacao-Cientifica/blob/master/images/CSV_Excel_meme.png?raw=true")

# ╔═╡ d13b4e84-94d0-4b2e-af5f-0fb0b387465c
md"""
!!! danger "⚠️ O problema do Excel"
    **Excel altera os dados de maneira silenciosa**.

	Por exemplo, [pesquisadores tiveram que mudar o nome de 27 Genes](https://www.theverge.com/2020/8/6/21355674/human-genes-rename-microsoft-excel-misreading-dates) pois o Excel pensava que eram datas (e.g `MARCH1` não é 1 de Março mas sim [Membrane Associated Ring-CH-Type Finger 1](https://www.genenames.org/data/gene-symbol-report/#!/hgnc_id/HGNC:26077). Mais de [1/5 dos estudos publicados com dados genéticos tem erros do Excel](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-1044-7).

	Além disso, **Excel "falha silenciosamente"**.

	Por exemplo, [um erro silencioso de Excel no pipeline de dados do COVID-19 no Reino Unido fez com que fosse subreportado mais de 15mil casos de COVID-19](https://www.engadget.com/microsoft-excel-england-covid-19-delay-114634846.html). Alguém muito inteligente usou o formato `.xls` que aguenta somente ≈65k linhas e depois disso ele para de escrever e não avisa o erro.

	>Veja mais histórias de horror do Excel no [European Spreadsheet Risk Interest Group](http://eusprig.org/horror-stories.htm).
"""

# ╔═╡ 7ba9ae9e-e141-4566-9db4-87b91aeed57b
md"""
Eu uso muito pouco Excel (aliás tenho asco de coisas pagas... 🤮). Só conheço duas funções de leitura e uma de escrita:

* `XLSX.readxlsx(file.xlsx)`: lê todo o arquivo XLSX e retorna uma espécie de índice de abas (_tabs_) e células. Ele funciona com um dicionário dá pra fazer uma indexação `xf["minha_aba"]`.


* `XLSX.readtable(file.xlsx, sheet)`: lê uma aba especifica do arquivo XLSX. Aceita como `sheet` uma `String` com o nome da aba ou um `Integer` começando em 1 com o índice da aba.
   * Essa função retorna uma tupla `(data, column_labels)` então é necessário colocar o operador *splat* `...` dentro do construtor `DataFrame`
   * Cuidado com o argumento `infer_eltypes`. Por padrão ele é `false` e vai te dar um `DataFrame` com um monte de colunas `Any`. Use `infer_eltypes = true`)


* `XLSX.writetable(file.xlsx, data, columnames)`: escreve um arquivo XLSX. Se atente que aqui precisa dos dados e do nome das colunas separados. `XLSX.writetable("df.xlsx", collect(eachcol(df)), names(df))`
"""

# ╔═╡ 4b03488e-634e-4c48-a84e-649d3dbf9c14
md"""
!!! tip "💡 Operações Avançadas com XLSX.jl"
    Veja esse [tutorial na documentação de `XLSX.jl`](https://felipenoris.github.io/XLSX.jl/dev/tutorial/). Tem várias maneiras de ler arquivos Excel: intervalo de células, arquivos grandes etc...
"""

# ╔═╡ d65393aa-9ece-44be-b1e6-1e73e4644d73
penguins_xlsx_file = joinpath(pwd(), "..", "data", "penguins.xlsx")

# ╔═╡ 9c003007-ec85-4e6d-81a0-6778224a2ea1
XLSX.readxlsx(penguins_xlsx_file)

# ╔═╡ 968878aa-7396-412c-9b6c-39f1cc199b1e
DataFrame(XLSX.readtable(penguins_xlsx_file, 1)...)

# ╔═╡ b331fa61-c49a-4e56-bcac-4a977d247637
md"""
# Funções de `DataFrames.jl`

São [muitas](https://dataframes.juliadata.org/dev/lib/functions/):

- `eachrow` e `eachcol`: iterador de linhas e colunas (dão suporte para funções `findnext`, `findprev`, `findfirst`, `findlast` e `findall`)
- `select` e `select!`: seleção e filtragem de colunas
- `filter`, `filter!`, `subset` e `subset!`: seleção e filtragem de linhas
- `sort` e `sort!`: ordenação de linhas
- `unique` e `unique!`: valores únicos de colunas
- `rename` e `rename!`: renomeamento de colunas
- `transform` e `transform!`: transformação/criação de colunas
- `insertcols!`: inserção de colunas
- `completecases`, `dropmissing`, `dropmissing!`, `allowmissing`, `allowmissing!`, `disallowmissing`, `disallowmissing!`, `coalesce`: valores faltantes
- `hcat`, `vcat`, `append!` e `push!`: concatenação de dados
- `combine`: sumarizações de colunas (muito usado com *joins*)
- `groupby`: agrupar dados por colunas
- `antijoin`, `crossjoin`, `innerjoin`, `leftjoin`, `outerjoin`, `rightjoin` e `semijoin`: *joins* de `DataFrame`s
- `stack`, `unstack` e `flatten`: redimensionamento de `DataFrame`s (formato *wide* ⇆ *long* e *nest* ⇆ *unnest*)
"""

# ╔═╡ 47325d97-c116-48c5-8c5a-b2525082a4ee
md"""
!!! tip "💡 Funções com !"
    Quase todas as funções de `DataFrames.jl` tem uma versão `funcao!` que faz a alteração *inplace* e retorna `nothing`. São funções convenientes e rápidas pois não geram alocações novas.
"""

# ╔═╡ 844deb5f-76ef-4857-b218-c6b3ff3e3646
md"""
# Indexação de `DataFrame`

Basicamente funciona assim, muito similar com as `Array`s:

```julia
df[row, col]
```

Onde:

* `row`:
   * uma única linha:
      * `Integer`: `df[1, col]`
      * `begin` e `end` também funcionam `df[end, col]`
   * várias linhas:
      * `UnitRange`: um intervalo `df[1:10, col]`
      * `Vector{Integer}`: `df[[1,2], col]`
      * `Vector{Bool}`: os índices que são `true`, `df[[false, true, true], col]`
   * todas as linhas:
      * `:`: todas as linhas (com cópia)
      * `!`: todas as linhas (sem cópia)
* `col`:
   * uma única coluna:
      * `Symbol`: `df[:, :col]`
      * `String`: `df[:, "col"]`
      * `Integer`: `df[:, 1]`
      * `begin` e `end` também funcionam `df[:, end]`
      * `df.col` também funciona e é igual a `df[!, :col]`
   * várias colunas:
      * `Vector{Symbol}`: `df[:, [:col1, :col2]]`
      * `Vector{String}`: `df[:, ["col1", "col2"]]`
      * `UnitRange`: um intervalo `df[:, 1:10]`
      * `Vector{Integer}`: várias linhas `df[:, [1,2]]`
      * `Vector{Bool}`: os índices que são `true`, `df[:, [false, true, true]]`
      * RegEx: `df[:, r"^col"]`
      * `Not`: uma negação bem flexível `df[:, Not(:col)]` ou `df[:, Not(1:5)]`
      * `Between`: um intervalo bem flexível `df[:, Between(:col1, :col5)]` ou `df[:, Between("col", 5)]`
      * `Cols`: seleção flexível de colunas `df[:, Cols(:col, "col", 5)]`
   * todas as colunas:
      * `:`
      * `All`: `df[:, All()]`
"""

# ╔═╡ 7eb0f340-7bb9-4942-a150-cbe0a9b89118
md"""
!!! tip "💡 Diferença entre df[!, :col] e df[:, :col]"
    `df[!, :col]`: substitui a coluna `:col` no `df` com um novo vetor passado no lado direito da expressão **sem copiar**.
	
	`df[:, :col]`: atualiza a coluna `:col` no `df` com um novo vetor passado no lado direito da expressão **fazendo uma cópia**.

	**O mais rápido é `df[!, :col]`**. `df[:, :col]` mantém a mesma coluna então faz checagem de tipo, não deixa você colocar uma coluna de tipos que não podem ser convertidos para o tipo original da coluna.

	> Note que `df[!, :col]` é o mesmo que `df.col`.
"""

# ╔═╡ ba120760-53a5-4b2b-929c-bcb939819334
md"""
## Linhas
"""

# ╔═╡ dc37999a-338b-4248-8bd8-07999fa09d1d
penguins[begin, :]

# ╔═╡ a51b287a-15e6-40f1-9eb2-bfd389af5731
penguins[1:10, :]

# ╔═╡ 689ff378-e97e-4632-9cac-9411ccfee789
penguins[[1,2], :]

# ╔═╡ 309e08fd-b84e-4c60-ac03-9574e5ff74bc
penguins[vcat(false, true, true, repeat([false], nrow(penguins)-3)), :]

# ╔═╡ 06e4452f-3ef7-41b6-a07d-20c5f3ce76ef
md"""
## Colunas
"""

# ╔═╡ f96c94ed-1235-4651-959e-e474fb6793a5
penguins.species

# ╔═╡ bc851d7c-8b9f-4a57-973a-d1a5076f2b9a
penguins[:, :species]

# ╔═╡ 6d6db43e-fb6d-4494-bf7e-d9bd2cc95e3d
penguins[:, end]

# ╔═╡ 69fc9893-5715-40b5-b192-3682828fb22e
penguins[:, 4]

# ╔═╡ a7282b59-3cbc-44d6-a91d-00ab6694cba0
penguins[:, 1:4]

# ╔═╡ 977b194a-302e-4965-93c4-226b8ca91440
penguins[:, r"mm$"] 

# ╔═╡ a170e72c-ae85-4a41-9447-08c5643ca994
penguins[:, Not(:species)]

# ╔═╡ 8f7cdd2d-2d3c-4c5e-a76a-79e4cdef5a68
penguins[:, Not(1:5)]

# ╔═╡ 3cc6096a-a559-489c-b70d-f7ee9c03a711
penguins[:, Cols(:species, "bill_length_mm", 5)]

# ╔═╡ 45c10fc6-b51c-43f0-8733-66114f31606c
md"""
!!! tip "💡 Designação"
    Qualquer indexação acima se você parear com um operador `=` de designação (`.=` vetorizado), você **altera os valores do `DataFrame`**. 

	```julia
	df[row, col] = ...    # um valor
	df[:, col] .= ...     # múltiplas linhas na mesma coluna
	df[row, :] .= ...     # múltiplas colunas na mesma linha
	```
"""

# ╔═╡ 543d473a-44a5-42b7-b820-7a3b5bd1d84e
md"""
# Semânticas de DataFrames.jl
"""

# ╔═╡ 3c75695c-6160-4385-a329-c52fe43ab283
md"""
!!! tip "💡 Semânticas de DataFrames.jl"
    Para muitas coisas `DataFrames.jl` usa a [semântica de `Pair`s](https://bkamins.github.io/julialang/2020/12/24/minilanguage.html):

	```julia
	:col => transformação => :nova_col
	```
"""

# ╔═╡ ebc8d4af-7257-4a74-bccd-8693c6fc26be
typeof(:age => mean => :mean_age)

# ╔═╡ 18a5f498-4d4d-4a47-ab5a-3b62df1c2d0b
md"""
# Selecionar Colunas de `DataFrame`

* `select`: retorna um `DataFrame`
* `select!`: retorna `nothing` e altera o `DataFrame` *inplace*

```julia
select(df, ...)
```

`select` e `select!` funcionam com todos os seletores de `col` que falamos acima:

* `select(df, :col1, :col2)`
* `select(df, [:col1, :col2])`
* `select(df, Not(:col1))`
* `select(df, Between(:col1, :col5))`
* `select(df, r"^col")`
* `select(df, Not(:col1))`
"""

# ╔═╡ 2bc2529d-8931-4300-8a64-97b349c37e2d
select(penguins, r"^bill")

# ╔═╡ 9ca94b93-d587-4f43-abeb-23d4125fdb47
md"""
## Renomear Colunas de `DataFrame`

Renomeação de colunas pode ser feito de duas maneiras:

1. **apenas renomeando**: passando um pair em `rename`
   ```julia
   rename(df, :col => :nova_col)
   ```

> Funciona com todos os seletores de `col`.
"""

# ╔═╡ 66c9b74d-ec9b-4d21-9b7f-87cb9756c29f
rename(penguins, :species => :especies, :island => :ilha)

# ╔═╡ 11be77ad-91f4-4d1d-a16f-5fd72941b9d5
md"""
2. **selecionando e renomeando**: passando um `Pair` em um `select`
   ```julia
   select(df, :col => :nova_col)
   ```
"""

# ╔═╡ c2d12ce6-0dcc-4ccf-8ea2-7365a7ff60d3
select(penguins, :species => :especies)

# ╔═╡ 03b63951-8e92-448c-8e1a-cc3857cc3e8d
md"""
## Inserir novas colunas com `insertcols!`

Podemos também inserir novas colunas com `insertcols!` (essa função não tem versão sem `!`):

```julia
insertcols!(df, :nova_col=...)
```

> Funciona com todos os seletores de `col`.

Por padrão se não especificarmos o índice que queremos inserir a coluna automaticamente ela é inserida no final do `DataFrame`.
Caso queira inserir em um índice específico é só indicar a posição após o argumento `df`:

```julia
insertcols!(df, 3, :nova_col=...)      # insere no índice 3
insertcols!(df, :col2, :nova_col=...)  # insere no índice da :col2
insertcols!(df, "col2", :nova_col=...) # insere no índice da :col2
```
"""

# ╔═╡ 6c629f13-1d3f-47a4-a0fa-a05a601a6274
md"""
## Reordenar Colunas

Suponha que você queria reordenar colunas de um dataset.

Você consegue fazer isso com o `select` (ou `select!`) e o seletores de `col`:
"""

# ╔═╡ 83d1b730-18b4-4835-8c39-f9dd86d7722e
starwars |> names # antes

# ╔═╡ cc691c4f-80a1-4a61-ab70-8b611913ade5
select(starwars, Between(1,:name), Between(:sex, :homeworld), :) |> names #depois

# ╔═╡ 8c73a569-2d31-413c-9464-3bda8d811fc0
md"""
# Ordenar Linhas de `DataFrame`

* sort: retorna um DataFrame
* sort!: retorna nothing e altera o `DataFrame` *inplace*

> Funciona com todos os seletores de `col`.

Por padrão é ordem crescente (`rev=false`) e ordena todas as colunas começando com a primeira coluna:
```julia
sort(df, cols; rev=false)
```
"""

# ╔═╡ e4134fcf-9117-4561-ae38-5628f6d660ca
sort(penguins, :bill_length_mm)

# ╔═╡ ec537d76-c7c3-4108-b92e-505ccc5d2e57
sort(penguins, [:species, :bill_length_mm]; rev=true)

# ╔═╡ 664b3514-dfbd-4b4e-8ede-5b6ada310eab
sort(penguins, Not(:species); rev=true)

# ╔═╡ c960e354-3f67-44ff-b5ca-5898bbbae67d
md"""
# Filtrar Linhas de `DataFrame`

* `filter`: retorna um DataFrame
* `filter!`: retorna nothing e altera o `DataFrame` *inplace*

```julia
filter(fun, df)
```

* `subset`: retorna um DataFrame
* `subset!`: retorna nothing e altera o `DataFrame` *inplace*

```julia
subset(df, :col => fun)
```

> Funciona com todos os seletores de `col`.
"""

# ╔═╡ cc50b948-f35f-4509-b39e-287acbd9ad74
md"""
!!! tip "💡 filter vs subset"
    `filter` é um **despacho múltiplo da função `Base.filter`**. Portanto, segue a mesma convenção de `Base.filter`: primeiro vem a função e depois a coleção, no caso `DataFrame`.

	`subset` é uma **função de `DataFrames.jl`** portanto a API é **consistente** com as outras funções: `função(df, ...)`.

	`filter` é **MUITO mais rápido**, mas `subset` é mais conveniente para **múltiplas condições de filtragem** e lida melhor com **dados faltantes**.
"""

# ╔═╡ 8ffbf3c6-f92f-46f7-bf45-410102dfe474
filter(:species => ==("Adelie"), penguins)

# ╔═╡ 83d5f454-592a-4425-812d-323eebb257fa
filter(row -> row.species == "Adelie" && row.island ≠ "Torgensen", penguins)

# ╔═╡ fe546a4f-ab05-49cc-8123-e7e713417d0e
filter([:species, :island] => (sp, is) -> sp == "Adelie" && is ≠ "Torgensen", penguins)

# ╔═╡ 511bbea9-e5f8-4082-89ae-0bde99a0b552
md"""
!!! danger "⚠️ filter não lida muito bem com missing"
    Tem que usar o `!ismissing`.
"""

# ╔═╡ 3b709446-6daf-4fd7-8b62-8ed64ac8cfa9
filter(row -> row.bill_length_mm > 40, penguins)

# ╔═╡ e1849ea8-6cb7-4001-9ae5-508793ee7f0f
filter(row -> !ismissing(row.bill_length_mm > 40), penguins)

# ╔═╡ c571d48e-627e-414c-8b42-9243b1e952da
md"""
!!! tip "💡 Missing: subset para a salvação"
    `filter` com `!ismissing` fica beeeeeeem verboso. Aí que entra o `subset` com `skipmissing=true`.
"""

# ╔═╡ 8bd9020d-bd31-4ce4-a3aa-b831d453ab17
subset(penguins, :bill_length_mm => ByRow(>(40)); skipmissing=true)

# ╔═╡ 8a922b3f-a38f-47f9-8dc0-cffd829a4e3c
md"""
!!! tip "💡 ByRow"
    Um *wrapper* (função de conveniência) para vetorizar (*brodcast*) a operação para toda as observações da coluna.

	`ByRow(fun)` ≡ `x -> fun.(x)`

	Mas o `ByRow` é [**mais rápido** que a função anônima vetorizada](https://discourse.julialang.org/t/performance-of-dataframes-subset-and-byrow/60577).
"""

# ╔═╡ a2e0a0b4-bda6-480b-908f-5c1ff72a2490
@benchmark subset(penguins, :bill_length_mm => ByRow(>(40)); skipmissing=true)

# ╔═╡ 2bfb7633-2325-49ac-9d0f-eb4baf32f853
@benchmark subset(penguins, :bill_length_mm => x -> x .> 40; skipmissing=true)

# ╔═╡ 1360ab11-5a21-4068-89b1-48b763318398
md"""
!!! tip "💡 Benchmarks filter vs subset"
    `filter` é **mais rápido**, mas ele fica beeeem verboso rápido...
"""

# ╔═╡ 9eb436a0-d858-4999-b785-217c9b8d82c0
@benchmark filter(:species => ==("Adelie"), penguins)

# ╔═╡ d33bef35-3591-472d-b31f-305308318a8d
@benchmark filter(row -> row.species == "Adelie", penguins)

# ╔═╡ 714b5152-6258-4ce2-b54c-410ebac24275
@benchmark subset(penguins, :species => ByRow(==("Adelie")))

# ╔═╡ dcca805f-2778-4c41-8995-a90f14e44552
@benchmark subset(penguins, :species => x -> x .== "Adelie")

# ╔═╡ e8829151-00b9-4cdc-8023-e0b1b53f2f5d
md"""
!!! tip "💡 Benchmarks filter vs subset"
    `filter` é realmente **MUITO mais rápido**.
"""

# ╔═╡ 6e98e03f-5a0c-44a9-a379-4e7a61dc4bbd
@benchmark filter([:species, :island] => (sp, is) -> sp == "Adelie" && is ≠ "Torgensen", penguins)

# ╔═╡ a4fde68a-ce63-4859-a679-ad2c69722e77
@benchmark subset(penguins,  [:species, :island] => ByRow((sp, is) -> sp ==("Adelie") && is ≠("Torgensen")))

# ╔═╡ 5d18d2c3-b2e4-4b67-bbf2-fbed41ba4f88
@benchmark subset(penguins, :species => ByRow(==("Adelie")), :island => ByRow(≠("Torgensen")))

# ╔═╡ 8a853221-931b-4e81-be90-27c1f92f3d35
md"""
# Transformações de `DataFrame`

* `transform`: retorna um DataFrame
* `transform!`: retorna nothing e altera o `DataFrame` *inplace*

> Funciona com todos os seletores de `col`.
"""

# ╔═╡ 11c7082d-36a8-4653-81cb-8fd95bf2c5ad
transform(penguins, names(penguins, r"mm$") .=> ByRow(x -> x/10))

# ╔═╡ 70cb0f17-46ef-4771-a8e0-208aabb84d21
cols_mm = names(penguins, r"mm$")

# ╔═╡ 9197d244-889f-4fef-a6d4-495e03b44a5a
cols_cm = replace.(cols_mm, "mm" => "cm")

# ╔═╡ 3842cd95-2b12-4e10-b12f-3c41bb24702c
transform(penguins, cols_mm .=> ByRow(x -> x/10) .=> cols_cm)

# ╔═╡ d3bd0723-002f-4e43-8e9f-fb40e60770c9
md"""
!!! tip "💡 O mundo não é feito de funções anônonimas"
    Você pode usar também funções existentes ou criadas por você.
"""

# ╔═╡ 0e8f6918-393f-4756-8722-3bf3bf094522
function mm_to_cm(x)
	return x / 10
end

# ╔═╡ a489eea5-fbe1-499c-9a77-5d9da26815e9
transform(penguins, cols_mm .=> ByRow(mm_to_cm) .=> cols_cm)

# ╔═╡ 695a3cbc-6664-4ab9-a059-ef0ed454be16
md"""
!!! tip "💡 Sem renomear colunas"
	`transform` e `tranform!` também aceitam um argumento `renamecols` que por padrão é `true`.

	Se você passar `renamecols=false` as colunas não são renomeadas para `col_function`
"""

# ╔═╡ 131d0f27-1b89-4c59-a7fb-3928217e971c
transform(penguins, cols_mm .=> ByRow(mm_to_cm); renamecols=false)

# ╔═╡ 7ca7168c-fa55-4808-be9c-e33b5df21708
md"""
!!! tip "💡 ifelse"
    Uma função interessante de se ter no bolso é a `ifelse`.
"""

# ╔═╡ a952354f-84b0-4050-a78f-002a953b0c48
select(penguins, :body_mass_g => ByRow(x -> ifelse(coalesce(x, 0) > mean(skipmissing(penguins.body_mass_g)), "pesado", "leve")) => :peso)

# ╔═╡ 7f96c3c1-a93e-401d-9993-2c857f4002f5
md"""
!!! danger "⚠️ coalesce"
    Aqui eu fiz todos os `missing` de `:body_mass_g` virarem `0`.

	Veja a próxima seção sobre **Dados Ausentes**.
"""

# ╔═╡ 4818c8d6-d421-46ed-a31d-cade0ed1e5a8
md"""
## Exemplo mais Complexo com `starwars`
"""

# ╔═╡ e1abe2d3-6296-447a-a53a-d669f554ac8f
transform(
	dropmissing(select(starwars, Between(:name, :mass), :gender, :species)),
	[:height, :mass, :species] =>
                          ByRow((height, mass, species) ->
                                height > 200 || mass > 200 ? "large" :
                                species == "Droid" ? "robot" :
                                "other") =>
                          :type)

# ╔═╡ 857136e8-c2fc-4473-86ed-f351b2af17c6
md"""
# Sumarizações de Dados

As vezes você quer fazer coisas mais complexas que um `describe(df)` conseguiria fazer.

Nessas horas que entra o `combine`. Essa função retorna um dataframe apenas com as colunas especificadas e com as linhas determinadas pela transformação.

```julia
combine(df, ...)
```
"""

# ╔═╡ 7f05e0b8-2fd8-4bf6-a17a-83ed728d920f
md"""
!!! tip "💡 combine e groupby"
    `combine` é bastante utilizado com `groupby`. Isto vai ser coberto na seção de **Agrupamentos de `DataFrame`**.
"""

# ╔═╡ 7c81da5c-bc38-4f02-b613-fa783fde5e34
combine(penguins, nrow, :body_mass_g => mean ∘ skipmissing => :mean_body_mass)

# ╔═╡ f3ed3917-e855-4b14-b76f-e2d09c74e958
md"""
!!! info "💁 Composição de funções com ∘"
    Matematicamente o símbolo ∘ é o simbolo de composição de funções:
	
	$$f \circ g(x) = f(g(x))$$

	Então no nosso caso:
	```julia
	mean ∘ skipmissing == mean(skipmissing())
	```
"""

# ╔═╡ f155e53e-58e0-4535-bc9c-6c1dd6989d76
md"""
Ou fazer coisas mais complicadas:
"""

# ╔═╡ 130b1d66-e806-4a90-a2fe-f75fd7f4c2c5
combine(
	dropmissing(select(penguins, :body_mass_g, names(penguins, r"mm$"))), 
		[:body_mass_g, :bill_length_mm] => cor,
	    [:body_mass_g, :bill_depth_mm] => cor,
	    [:body_mass_g, :flipper_length_mm] => cor)

# ╔═╡ 7d67c6c6-15df-4b42-9ba7-cab2ae02cfb1
md"""
# Lidando com Dados Ausentes de `DataFrame`
"""

# ╔═╡ d7c3676e-0875-4755-83e7-b15fdcfdd9de
md"""
# Dados Categóricos com `CategoricalArrays`
"""

# ╔═╡ 971c9aa8-e5d4-41c3-9147-8bb95edb6dd7
md"""
# Agrupamento de `DataFrame`

Split/Apply/Combine e `GroupedDataFrame`
"""

# ╔═╡ 6113bca4-9f27-4453-827c-56bd0667d9d6
md"""
# Joins de `DataFrame`
"""

# ╔═╡ 26d3ecfa-6240-4dfc-9f73-14005d7c3191
md"""
# Redimensionamento de `DataFrame`

`stack` e `unstack`
"""

# ╔═╡ d548bc1a-2e20-4b7f-971b-1b07faaa4c13
md"""
## Ambiente
"""

# ╔═╡ 23974dfc-7412-4983-9dcc-16e7a3e7dcc4
with_terminal() do
	deps = [pair.second for pair in Pkg.dependencies()]
	deps = filter(p -> p.is_direct_dep, deps)
	deps = filter(p -> !isnothing(p.version), deps)
	list = ["$(p.name) $(p.version)" for p in deps]
	sort!(list)
	println(join(list, '\n'))
end

# ╔═╡ 93ae2b3a-67fb-46d2-b082-6dc47c1b8f7a
md"""
# Licença

Este conteúdo possui licença [Creative Commons Attribution-ShareAlike 4.0 Internacional](http://creativecommons.org/licenses/by-sa/4.0/).

[![CC BY-SA 4.0](https://licensebuttons.net/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
CategoricalArrays = "324d7699-5711-5eae-9e2f-1d82baa6b597"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
InteractiveUtils = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
XLSX = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"

[compat]
BenchmarkTools = "~1.1.1"
CSV = "~0.8.5"
CategoricalArrays = "~0.10.0"
DataFrames = "~1.2.1"
HTTP = "~0.9.12"
PlutoUI = "~0.7.9"
XLSX = "~0.7.6"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Statistics", "UUIDs"]
git-tree-sha1 = "c31ebabde28d102b602bada60ce8922c266d205b"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.1.1"

[[CSV]]
deps = ["Dates", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode"]
git-tree-sha1 = "b83aa3f513be680454437a0eee21001607e5d983"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.8.5"

[[CategoricalArrays]]
deps = ["DataAPI", "Future", "JSON", "Missings", "Printf", "RecipesBase", "Statistics", "StructTypes", "Unicode"]
git-tree-sha1 = "1562002780515d2573a4fb0c3715e4e57481075e"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.0"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "dc7dedc2c2aa9faf59a55c622760a25cbefbe941"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.31.0"

[[Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[DataAPI]]
git-tree-sha1 = "ee400abb2298bd13bfc3df1c412ed228061a2385"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.7.0"

[[DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "a19645616f37a2c2c3077a44bc0d3e73e13441d7"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.2.1"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4437b64df1e0adccc3e5d1adbc3ac741095e4677"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.9"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[EzXML]]
deps = ["Printf", "XML2_jll"]
git-tree-sha1 = "0fa3b52a04a4e210aeb1626def9c90df3ae65268"
uuid = "8f5d6c58-4d21-5cfd-889c-e3ad7ee6a615"
version = "1.1.0"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "c6a1fff2fd4b1da29d3dccaffb1e1001244d844e"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.12"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InvertedIndices]]
deps = ["Test"]
git-tree-sha1 = "15732c475062348b0165684ffe28e85ea8396afc"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.0.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "81690084b6198a2e1da36fcfda16eeca9f9f24e4"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.1"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "4ea90bd5d3985ae1f9a908bd4500ae88921c5ce7"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.0"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "c8abc88faa3f7a3950832ac5d6e690881590d6dc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "cde4ce9d6f33219465b55162811d8de8139c0414"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.2.1"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "0d1245a357cc61c8cd61934c07447aa569ff22e6"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.1.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[RecipesBase]]
git-tree-sha1 = "b3fb709f3c97bfc6e948be68beeecb55a0b340ae"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.1.1"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "944ced306c76ae4a5db96fc85ec21f501f06b302"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.4"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "e36adc471280e8b346ea24c5c87ba0571204be7a"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.7.2"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "8ed4a3ea724dac32670b062be3ef1c1de6773ae8"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.4.4"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[XLSX]]
deps = ["Dates", "EzXML", "Printf", "Tables", "ZipFile"]
git-tree-sha1 = "7744a996cdd07b05f58392eb1318bca0c4cc1dc7"
uuid = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"
version = "0.7.6"

[[XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[ZipFile]]
deps = ["Libdl", "Printf", "Zlib_jll"]
git-tree-sha1 = "c3a5637e27e914a7a445b8d0ad063d701931e9f7"
uuid = "a5390f91-8eb1-5f08-bee0-b1d1ffed6cea"
version = "0.9.3"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─cbc48ca5-f1a4-4e13-9323-2fd2c43d8612
# ╟─7bb67403-d2ac-4dc9-b2f1-fdea7a795329
# ╟─a20561ca-2f63-4ff4-8cff-5f93da0e940c
# ╠═27f62732-c909-11eb-27ee-e373dce148d9
# ╟─98ddb212-89ff-4376-8103-fb6c9518d0f7
# ╟─f8557972-abb6-4fc1-9007-8d6fb91ca184
# ╟─b22870c8-fc29-451d-afcf-4e07823291fc
# ╟─0bdad8c0-837c-4814-a8d9-e73bec34399e
# ╟─0553799f-c084-4f24-85c4-6da4c26cf524
# ╟─4722d7bc-789f-4c4b-966f-483fd276a243
# ╟─99c0cc2a-b538-4b42-8a6e-ddf4d93c5baa
# ╟─edeabce5-2296-4eb5-9410-cdb9b6187e7e
# ╟─c390de55-1f7c-4278-9d99-fd75c94f5e9d
# ╟─9197ec1a-eb2b-4dea-bb96-5ff16a9c423f
# ╟─f5f02b1c-0734-4e00-8b78-fab0ef6ab6c2
# ╟─750df153-fb1c-4b65-bc17-6d408000e422
# ╟─e4f7f01e-76bb-4f26-b231-0a01d817fc33
# ╠═7a47a8d3-0408-4e8a-bcd9-ffaf696eae81
# ╠═4f8b256e-9069-4d23-bf9e-a95867ffe3da
# ╟─a6b81169-b0cf-49e6-a700-d3618d7aeae9
# ╠═50af3d7c-535d-42fc-8fc5-d124210055e5
# ╠═06a37ad8-2ff7-4999-9008-98aa96b73420
# ╠═5da74073-e6cd-4ce9-a994-797be0e59ff8
# ╠═843ac012-f8f1-4655-84e2-ffb151b99bea
# ╟─c4efdf84-8700-4ed9-b40a-965d9188ffbc
# ╟─de547f28-1eb5-4438-b088-adbeae032f55
# ╠═877c0807-b9a9-406c-ac5d-dd7478a197c6
# ╟─7f223d58-4bd1-4b3d-9c14-9d84d0b8e7dd
# ╠═d73508d0-649c-46c5-be35-fc0ae7990ee3
# ╟─77d83116-8d87-4313-aaaf-e57d0322c3fe
# ╠═39a3b34d-2cb5-4033-a243-c13af0a49b2c
# ╟─8d4c63fe-2c4c-40d4-b079-7a4fd2b55142
# ╠═ae553b32-49a0-4c45-950b-bb4400e069ae
# ╟─8959d49d-b019-442d-adb6-99c1450ec108
# ╟─bd0fdeff-13c8-445e-86fc-bd619bd37645
# ╟─811b2abe-a7ff-4985-a4a2-2b03301dc099
# ╟─07e01ad7-2f1c-45fd-88aa-a7e5e528fd52
# ╟─ba30be06-4c47-4e13-a263-2d3b77e78802
# ╟─68e791a3-cfff-4115-8cbe-b7cc40b67bc4
# ╟─75984809-48aa-4c14-a193-23695831c1b7
# ╟─456acc71-3199-481c-b37c-0041ddb18a11
# ╟─dd760bda-855b-41a0-bc59-be46943c5705
# ╟─0224e6af-4b4b-45d8-b7a2-3a8152638b6a
# ╠═b4ed9851-3c64-4d10-8160-5d2e90681e72
# ╠═04b9e718-44a5-4e4d-9d4a-10b72a140e3c
# ╠═6c7e84cd-0747-4291-ace4-e1b0fa079c97
# ╠═f6d41644-3d13-4d4a-b8b8-c3fc9abec689
# ╠═fafdd689-6c1f-4036-aeb8-47c75cc73e9f
# ╟─ca69e258-32eb-479f-ab67-8d6969dc77ce
# ╟─0f601a7e-8b3c-4807-82cd-38cd448395b9
# ╟─d13b4e84-94d0-4b2e-af5f-0fb0b387465c
# ╟─7ba9ae9e-e141-4566-9db4-87b91aeed57b
# ╟─4b03488e-634e-4c48-a84e-649d3dbf9c14
# ╠═d65393aa-9ece-44be-b1e6-1e73e4644d73
# ╠═9c003007-ec85-4e6d-81a0-6778224a2ea1
# ╠═968878aa-7396-412c-9b6c-39f1cc199b1e
# ╟─b331fa61-c49a-4e56-bcac-4a977d247637
# ╟─47325d97-c116-48c5-8c5a-b2525082a4ee
# ╟─844deb5f-76ef-4857-b218-c6b3ff3e3646
# ╟─7eb0f340-7bb9-4942-a150-cbe0a9b89118
# ╟─ba120760-53a5-4b2b-929c-bcb939819334
# ╠═dc37999a-338b-4248-8bd8-07999fa09d1d
# ╠═a51b287a-15e6-40f1-9eb2-bfd389af5731
# ╠═689ff378-e97e-4632-9cac-9411ccfee789
# ╠═309e08fd-b84e-4c60-ac03-9574e5ff74bc
# ╟─06e4452f-3ef7-41b6-a07d-20c5f3ce76ef
# ╠═f96c94ed-1235-4651-959e-e474fb6793a5
# ╠═bc851d7c-8b9f-4a57-973a-d1a5076f2b9a
# ╠═6d6db43e-fb6d-4494-bf7e-d9bd2cc95e3d
# ╠═69fc9893-5715-40b5-b192-3682828fb22e
# ╠═a7282b59-3cbc-44d6-a91d-00ab6694cba0
# ╠═977b194a-302e-4965-93c4-226b8ca91440
# ╠═a170e72c-ae85-4a41-9447-08c5643ca994
# ╠═8f7cdd2d-2d3c-4c5e-a76a-79e4cdef5a68
# ╠═3cc6096a-a559-489c-b70d-f7ee9c03a711
# ╟─45c10fc6-b51c-43f0-8733-66114f31606c
# ╟─543d473a-44a5-42b7-b820-7a3b5bd1d84e
# ╟─3c75695c-6160-4385-a329-c52fe43ab283
# ╠═ebc8d4af-7257-4a74-bccd-8693c6fc26be
# ╟─18a5f498-4d4d-4a47-ab5a-3b62df1c2d0b
# ╠═2bc2529d-8931-4300-8a64-97b349c37e2d
# ╟─9ca94b93-d587-4f43-abeb-23d4125fdb47
# ╠═66c9b74d-ec9b-4d21-9b7f-87cb9756c29f
# ╟─11be77ad-91f4-4d1d-a16f-5fd72941b9d5
# ╠═c2d12ce6-0dcc-4ccf-8ea2-7365a7ff60d3
# ╟─03b63951-8e92-448c-8e1a-cc3857cc3e8d
# ╟─6c629f13-1d3f-47a4-a0fa-a05a601a6274
# ╠═83d1b730-18b4-4835-8c39-f9dd86d7722e
# ╠═cc691c4f-80a1-4a61-ab70-8b611913ade5
# ╟─8c73a569-2d31-413c-9464-3bda8d811fc0
# ╠═e4134fcf-9117-4561-ae38-5628f6d660ca
# ╠═ec537d76-c7c3-4108-b92e-505ccc5d2e57
# ╠═664b3514-dfbd-4b4e-8ede-5b6ada310eab
# ╟─c960e354-3f67-44ff-b5ca-5898bbbae67d
# ╟─cc50b948-f35f-4509-b39e-287acbd9ad74
# ╠═8ffbf3c6-f92f-46f7-bf45-410102dfe474
# ╠═83d5f454-592a-4425-812d-323eebb257fa
# ╠═fe546a4f-ab05-49cc-8123-e7e713417d0e
# ╟─511bbea9-e5f8-4082-89ae-0bde99a0b552
# ╠═3b709446-6daf-4fd7-8b62-8ed64ac8cfa9
# ╠═e1849ea8-6cb7-4001-9ae5-508793ee7f0f
# ╟─c571d48e-627e-414c-8b42-9243b1e952da
# ╠═8bd9020d-bd31-4ce4-a3aa-b831d453ab17
# ╟─8a922b3f-a38f-47f9-8dc0-cffd829a4e3c
# ╠═a2e0a0b4-bda6-480b-908f-5c1ff72a2490
# ╠═2bfb7633-2325-49ac-9d0f-eb4baf32f853
# ╟─1360ab11-5a21-4068-89b1-48b763318398
# ╠═9eb436a0-d858-4999-b785-217c9b8d82c0
# ╠═d33bef35-3591-472d-b31f-305308318a8d
# ╠═714b5152-6258-4ce2-b54c-410ebac24275
# ╠═dcca805f-2778-4c41-8995-a90f14e44552
# ╟─e8829151-00b9-4cdc-8023-e0b1b53f2f5d
# ╠═6e98e03f-5a0c-44a9-a379-4e7a61dc4bbd
# ╠═a4fde68a-ce63-4859-a679-ad2c69722e77
# ╠═5d18d2c3-b2e4-4b67-bbf2-fbed41ba4f88
# ╟─8a853221-931b-4e81-be90-27c1f92f3d35
# ╠═11c7082d-36a8-4653-81cb-8fd95bf2c5ad
# ╠═70cb0f17-46ef-4771-a8e0-208aabb84d21
# ╠═9197d244-889f-4fef-a6d4-495e03b44a5a
# ╠═3842cd95-2b12-4e10-b12f-3c41bb24702c
# ╟─d3bd0723-002f-4e43-8e9f-fb40e60770c9
# ╠═0e8f6918-393f-4756-8722-3bf3bf094522
# ╠═a489eea5-fbe1-499c-9a77-5d9da26815e9
# ╟─695a3cbc-6664-4ab9-a059-ef0ed454be16
# ╠═131d0f27-1b89-4c59-a7fb-3928217e971c
# ╟─7ca7168c-fa55-4808-be9c-e33b5df21708
# ╠═a952354f-84b0-4050-a78f-002a953b0c48
# ╟─7f96c3c1-a93e-401d-9993-2c857f4002f5
# ╟─4818c8d6-d421-46ed-a31d-cade0ed1e5a8
# ╠═e1abe2d3-6296-447a-a53a-d669f554ac8f
# ╟─857136e8-c2fc-4473-86ed-f351b2af17c6
# ╟─7f05e0b8-2fd8-4bf6-a17a-83ed728d920f
# ╠═7c81da5c-bc38-4f02-b613-fa783fde5e34
# ╟─f3ed3917-e855-4b14-b76f-e2d09c74e958
# ╟─f155e53e-58e0-4535-bc9c-6c1dd6989d76
# ╠═130b1d66-e806-4a90-a2fe-f75fd7f4c2c5
# ╠═7d67c6c6-15df-4b42-9ba7-cab2ae02cfb1
# ╠═d7c3676e-0875-4755-83e7-b15fdcfdd9de
# ╠═971c9aa8-e5d4-41c3-9147-8bb95edb6dd7
# ╠═6113bca4-9f27-4453-827c-56bd0667d9d6
# ╠═26d3ecfa-6240-4dfc-9f73-14005d7c3191
# ╟─d548bc1a-2e20-4b7f-971b-1b07faaa4c13
# ╟─228e9bf1-cfd8-4285-8b68-43762e1ae8c7
# ╟─23974dfc-7412-4983-9dcc-16e7a3e7dcc4
# ╟─93ae2b3a-67fb-46d2-b082-6dc47c1b8f7a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
