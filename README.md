# Scripts para geração de certificado da 2a CiDWeek

Estes scripts foram usados para gerar os certificados da 2a CiDWeek.
Para usá-los, é necessário:

- `inscritos.csv` com a lista de inscritos. As colunas "Email Address" e "Nome Completo" são usadas.
- `presença.xlsx` com as listas de presenças. A segunda coluna de cada sheet é assumida ter os e-mails.
- `palestrantes.csv` com os palestrantes (nome,titulo) sem cabeçalho.
- `template-palestrantes.png` com um template do certificado para os palestrantes.
- `template-participantes.png` com um template do certificado para os participantes.
- A fonte LibreBaskerville que pode ser obtida aqui: https://fonts.google.com/specimen/Libre+Baskerville
- ImageMagick instalado.

Os scripts foram rodados com Julia 1.6 e os pacotes
- CSV 0.8.4
- DataFrames 1.0.1
- XLSX 0.7.6

São 3 scripts:
- `agrega-participantes.jl`: Agrega `presença.xlsx` usando um vetor de pesos (em horas) para cada sheet, depois busca em `inscritos.csv` esses e-mails e cria `participantes.csv` com e-mail, nome e horas do certificado.
- `palestrantes.jl` e `participantes.jl`: usando o csv e o template respectivos, anota o nome e, ou o título da palestra, ou o número de horas, respectivamente, nesse template. Faz isso por meio do ImageMagick. A fonte LibreBaskerville é usada aqui.

## Atualização

Algumas pessoas assinaram as chamadas com e-mail diferentes da inscrição, fazendo com que os scripts acima não peguem sua participação. Para remediar, 2 scripts foram adicionados:

- `faltantes.jl`: Calcula o número de horas que os e-mails fantantes tiveram, para uso no próximo script. Lê do arquivo `faltantes.csv` para gerar o arquivo `faltantes-horas.csv`.
- `manual.jl`: Lê do arquivo `manual.csv` para gerar certificados. O arquivo `manual.csv` deve ser preenchido manualmente. Usando o arquivo `faltante-horas.csv` dá pra saber quantas horas o e-mail teve, mas o nome é onde entra a parte manual.

## Licença

Estes scripts podem ser reutilizados sob a [licença MIT](LICENSE).
