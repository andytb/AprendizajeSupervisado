# Install dependencies in Linux
# sudo apt-get install libcurl4-openssl-dev 

install = function(pkg){
  # Si ya esta instalado, no lo instala.
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, repos = "http:/cran.rstudio.com")
    if (!require(pkg, character.only = TRUE)) stop(paste("load failure:", pkg))
  }
}

install("jsonlite")

fetch_data = function(preamble, list){
  data = preamble
  for(elem in list){
    data = paste0(data, paste0(strsplit(elem, " ")[[1]], collapse = "+"), "|", collapse = "") 
  }
  return(substr(data, 0, nchar(data)-1))
}

get_url = function(origins, destinations, key, mode = "driving", language = "es"){
  # install(pkg)
  # url base for distance matrix api
  base = "https://maps.googleapis.com/maps/api/distancematrix/json?"
  
  # This could change, using only some atributes from API
  origin = fetch_data("origins=", origins)
  destination = fetch_data("destinations=", destinations)
  key = fetch_data("key=", key)
  mode = fetch_data("mode=", mode)
  language = fetch_data("language=", language)
  
  # Getting final format for Google API
  api_url = paste(c(base, paste0(c(origin, destination, key, mode, language), collapse = "&")), collapse = "")
  
  return(api_url)
}

get_data = function(api_url){
  return(fromJSON(api_url))
}

# To Complete
parse_data = function(origen_list, destny_list, api_key, mode = "driving", language = "es"){
  #Separar la lista en pedazos para que puedan ser procesada por el API de Google
  origen_list2<-origen_list[1:40]
  origen_list3<-origen_list[41:80]
  origen_list4<-origen_list[81:120]
  origen_list5<-origen_list[121:160]
  
  # Colocar su API Key 
  api_key = "AIzaSyCS6AqTNIPGnPzIMGpyfianRvq5X1bwu9s"
  api_url = get_url(origen_list2, destny_list, api_key)
  datos = get_data(api_url)
  datos2 <- unlist(datos$rows)
  api_url = get_url(origen_list3, destny_list, api_key)
  datos = get_data(api_url)
  datos3 <- unlist(datos$rows)
  api_url = get_url(origen_list4, destny_list, api_key)
  datos = get_data(api_url)
  datos4 <- unlist(datos$rows)
  api_url = get_url(origen_list5, destny_list, api_key)
  datos = get_data(api_url)
  datos5 <- unlist(datos$rows)
  
  datos <- append(datos2, datos3, after = length(datos2))
  datos <- append(datos, datos4, after = length(datos))
  datos <- append(datos, datos5, after = length(datos))
  datos <- datos[grep("elements.duration.value", names(datos))]
  return (datos)
}