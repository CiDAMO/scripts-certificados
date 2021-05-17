using CSV, DataFrames

function main()
  file = "participantes.csv"
  data = CSV.read(file, DataFrame, header=true)
  data = sort(data, ["Nome Completo"])
  isdir("participantes") || mkdir("participantes")

  n = size(data, 1)
  for i = 1:n
    nome = titlecase(data[i,2])
    horas = data[i,3]
    filename = join(split(nome), "_")
    d1 = "gravity Center text 0,-230 \"$nome\""
    d2 = "gravity Center text 0,160 \"$horas horas.\""

    tmp = "tmp.png"

    cmd = `convert -pointsize 80 -draw $d1 -font LibreBaskerville-Italic.ttf template-participantes.png tmp.png`
    run(cmd)
    cmd = `mogrify -pointsize 50 -draw $d2 -font LibreBaskerville-Italic.ttf tmp.png`
    run(cmd)
    cmd = `convert tmp.png participantes/$filename.pdf`
    run(cmd)
  end
end

main()
