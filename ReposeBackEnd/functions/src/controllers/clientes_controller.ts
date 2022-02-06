import { db } from "../index";
import {Request, Response} from "express";
import {Clientes as clientes} from "../models/clientes";
import { Respuesta } from "../models/respuesta";



export async function createclientes(req: Request, res: Response) {           
    try{                    
        const newclientes = clientes(req.body);
        const clientesAdded = await db.collection("clientes").add(newclientes);                            
        return res.status(201).json(Respuesta('Cliente agregado', `El Cliente fue agregado correctamente con el id ${clientesAdded.id}`, newclientes, 201));
    }
    catch(err){
        return handleError(res, err);
    }
}

export async function consultarclientes(req: Request, res: Response) {           
    try{
        const doc = await db.collection("clientes").doc(req.params.id).get();
        if(!doc) {
            return res.status(404).json(Respuesta('clientes no encontrado', `clientes con el id ${req.params.id} no encontrado`, {req}, 404));               
        }        
        return res.status(200).json(clientes(doc.data(), doc.id));
    }
    catch(err){
        return handleError(res, err);
    }
}

export async function listclientes(req: Request, res: Response) {       
    try {        
        let snapshot = await db.collection("clientes").get();
        return res.status(200).json(snapshot.docs.map(doc => clientes(doc.data(), doc.id)));                
    } catch (err) {
        return handleError(res, err);
    }       
};


function handleError(res: Response, err: any){
    return err.status(500).send({message: `${err.code} - ${err.message}`});
}