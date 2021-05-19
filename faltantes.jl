using XLSX, CSV, DataFrames

function main()
  faltantes = CSV.read("faltantes.csv", DataFrame)
  n = size(faltantes, 1)
  faltantes = [faltantes DataFrame(horas = zeros(Int, n))]
  xlsx = XLSX.readxlsx("presença.xlsx")
  pesos = [3, 2, 3, 2, 4, 2, 4, 2, 2, 4]
  for i in 1:XLSX.sheetcount(xlsx)
    sh = xlsx[i]
    emails = unique(sort(lowercase.(sh["B"][2:end])))
    I = indexin(emails, faltantes[!, "email"])
    I = I[findall(I .!== nothing)]
    faltantes[I, "horas"] .+= pesos[i]
  end
  CSV.write("faltantes-horas.csv", faltantes)
end

main()
