import { db } from "../index";
import {Request, Response} from "express";


export async function list(req: Request, res:Response){
    try {
        let snapshot = await db.collection("SitiosDeInterezEcuador").get();
        return res.status(200).json(snapshot.docs);
    } catch (err) {
        return handleError(res, err);
    }
};

function handleError(res: Response, err: any){
    return err.status(500).send({message: `${err.code} - ${err.message}`});
}