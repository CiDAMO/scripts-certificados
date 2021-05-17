using CSV, DataFrames

function processa_titulo(titulo)
  if length(titulo) > 60
    s = split(titulo)
    n = div(length(s), 2)
    titulo = join(s[1:n], " ") * "\n" * join(s[n+1:end], " ")
  end
  return titulo
end

function main()
  file = "palestrantes.csv"
  data = CSV.read(file, DataFrame, header=false)
  isdir("palestrantes") || mkdir("palestrantes")

  n = size(data, 1)
  for i = 1:n
    nome = titlecase(data[i,1])
    titulo = processa_titulo(data[i,2])
    filename = join(split(nome), "_")
    d1 = "gravity Center text 0,-280 \"$nome\""
    d2 = "gravity Center text 0,80 \"$titulo.\""

    tmp = "tmp.png"

    cmd = `convert -pointsize 80 -draw $d1 -font LibreBaskerville-Italic.ttf template-palestrantes.png tmp.png`
    run(cmd)
    cmd = `mogrify -pointsize 50 -draw $d2 -font LibreBaskerville-Italic.ttf tmp.png`
    run(cmd)
    cmd = `convert tmp.png palestrantes/$filename.pdf`
    run(cmd)
  end
end

main()
