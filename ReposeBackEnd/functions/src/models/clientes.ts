
export interface Clientes {
    idclientes?: String,
    nombre_cli: String,
    email_cli: String,
    password_cli: String,
    rol: String,
}

export function Clientes(data :any, id?:string){
    const { nombre_cli,email_cli, password_cli,rol } = data;

    let object :Clientes = {
        idclientes: id, 
        nombre_cli: nombre_cli,
        email_cli: email_cli,
        password_cli: password_cli,
        rol: rol,
    };
    return object;
}