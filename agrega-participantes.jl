using XLSX, CSV, DataFrames

function main()
  inscritos = CSV.read("inscritos.csv", DataFrame)
  n = size(inscritos, 1)
  presenca = [inscritos[!, ["Email Address", "Nome Completo"]] DataFrame(horas = zeros(Int, n))]
  xlsx = XLSX.readxlsx("presença.xlsx")
  pesos = [3, 2, 3, 2, 4, 2, 4, 2, 2, 4]
  perdidos = []
  for i in 1:XLSX.sheetcount(xlsx)
    sh = xlsx[i]
    emails = unique(sort(lowercase.(sh["B"][2:end])))
    I = indexin(emails, presenca[!, "Email Address"])
    M = findall(I .=== nothing)
    append!(perdidos, emails[M])
    I = findall(I .!== nothing)
    presenca[I, "horas"] .+= pesos[i]
  end
  I = findall(presenca.horas .> 0)
  CSV.write("participantes.csv", presenca[I,:])
  df = DataFrame(email = unique(sort(perdidos)))
  CSV.write("faltantes.csv", df)
end

main()
