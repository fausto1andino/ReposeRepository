export interface Respuesta {
    titulo: string;
    mensaje: string;
    resultado: object;    
};

export function Respuesta(titulo:string, mensaje:string, resultado: object){
    let respuesta :Respuesta = {
        titulo: titulo,
        mensaje: mensaje,
        resultado: resultado
    }
    return respuesta;
}