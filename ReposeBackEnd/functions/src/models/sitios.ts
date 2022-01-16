
export interface sitios {
    idsitios?: String,
    ciudad_sitio: String,
    costo_sitio: number,
    descripcion_sitio: String,
    nombre_sitio: String,
    urlImagen_sitio: String
}

export function sitios(data :any, id?:string){
    const { ciudad,costo,descripcion,nombre,urlImagen } = data;

    let object :sitios = {
        idsitios: id, 
        ciudad_sitio: ciudad,
        costo_sitio: costo,
        descripcion_sitio: descripcion,
        nombre_sitio: nombre,
        urlImagen_sitio: urlImagen
    };
    return object;
}