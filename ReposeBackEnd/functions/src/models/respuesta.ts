
export interface Respuesta {
    titulo: string;
    mensaje: string;
    resultado: object;    
    estado: number;
};

export function Respuesta(titulo:string, mensaje:string, resultado: object, estado: number){
    let respuesta :Respuesta = {
        titulo: titulo,
        mensaje: mensaje,
        resultado: resultado,
        estado: estado
    }
    return respuesta;
}