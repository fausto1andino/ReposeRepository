import { db } from "../index";
import {Request, Response} from "express";
import {sitios} from "../models/sitios";
import { Respuesta } from "../models/respuesta";



export async function createsitios(req: Request, res: Response) {           
    try{                    
        const newsitios = sitios(req.body);
        const sitiosAdded = await db.collection("sitios").add(newsitios);                            
        return res.status(201).json(Respuesta('sitio agregado', `El sitio fue agregado correctamente con el id ${sitiosAdded.id}`, newsitios, 201));
    }
    catch(err){
        return handleError(res, err);
    }
}

export async function consultarsitios(req: Request, res: Response) {           
    try{
        const doc = await db.collection("sitios").doc(req.params.id).get();
        if(!doc) {
            return res.status(404).json(Respuesta('sitios no encontrado', `sitios con el id ${req.params.id} no encontrado`, {req}, 404));               
        }        
        return res.status(200).json(sitios(doc.data(), doc.id));
    }
    catch(err){
        return handleError(res, err);
    }
}

export async function listsitios(req: Request, res: Response) {       
    try {        
        let snapshot = await db.collection("sitios").get();
        return res.status(200).json(snapshot.docs.map(doc => sitios(doc.data(), doc.id)));                
    } catch (err) {
        return handleError(res, err);
    }       
};


function handleError(res: Response, err: any){
    return err.status(500).send({message: `${err.code} - ${err.message}`});
}