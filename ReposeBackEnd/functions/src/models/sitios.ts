
export interface sitios {
    idsitios?: String,
    ciudad_sitio: String,
    costo_sitio: number,
    descripcion_sitio: String,
    nombre_sitio: String,
    urlImagen_sitio: String,
    lat: number,
    long: number
}

export function sitios(data :any, id?:string){
    const { ciudad_sitio,costo_sitio,descripcion_sitio,nombre_sitio,urlImagen_sitio,lat,long } = data;

    let object :sitios = {
        idsitios: id, 
        ciudad_sitio: ciudad_sitio,
        costo_sitio: costo_sitio,
        descripcion_sitio: descripcion_sitio,
        nombre_sitio: nombre_sitio,
        urlImagen_sitio: urlImagen_sitio,
        lat: lat,
        long: long
    };
    return object;
}