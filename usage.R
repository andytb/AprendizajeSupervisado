# Seleccionar google_api.R en su sistema de archivos
source(file.choose())

origen = c("Via del Fontanile Arenato Italia")
destino =c("Universita di Roma Sapienza")

# Colocar su API Key 
api_key = "AIzaSyCS6AqTNIPGnPzIMGpyfianRvq5X1bwu9s"

api_url = get_url(origen, destino, api_key)

datos = parse_data(api_url)
datos
dir <- ifelse(grepl("Via Endert", dir), "Via EndertÃ", dir)
dir <- ifelse(grepl("Via Tripolitana", dir), "Via Tripolitania", dir)