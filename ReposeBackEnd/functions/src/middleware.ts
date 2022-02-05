//Revisa el token de la authorization en el header de la 
//petición y determina permiso de Authentication / Authorization
import { Request, Response } from "express";
import * as admin from 'firebase-admin'
import { Respuesta } from "./models/respuesta";

export async function isAuthenticated(req: Request, res: Response, next: Function) {
    const { authorization } = req.headers
 
    if (!authorization)
        return res.status(401).send(Respuesta( 'No autorizado','Usuario sin autorización', {authorization}, 401));
 
    if (!authorization.startsWith('Bearer'))
        return res.status(401).send(Respuesta( 'No autorizado','Usuario sin autorizacion válida',{authorization},401));
 
    const split = authorization.split('Bearer ')
    if (split.length !== 2)
        return res.status(401).send(Respuesta('No autorizado','Usuario sin autorizacion válida',{authorization},401));
 
    const token = split[1]
 
    try {
        const decodedToken: admin.auth.DecodedIdToken = await admin.auth().verifyIdToken(token);
        console.log("decodedToken", JSON.stringify(decodedToken))
        res.locals = { ...res.locals, uid: decodedToken.uid, role: decodedToken.role, email: decodedToken.email }
        return next();
    }
    catch (err) {        
        return res.status(401).send(Respuesta('Error al autenticar','Error al autenticar el usuario',{err},401));
    }
}

export function isAuthorized(opts: { hasRole: Array<'admin' | 'tecnico'>}) {
    return (req: Request, res: Response, next: Function) => {
        const { role } = res.locals

        if (!role)
            return res.status(403).send(Respuesta('No autorizado','Usuario con el rol no autorizado', {role},403));
 
        if (opts.hasRole.includes(role))
            return next();
 
        return res.status(403).send(Respuesta('No autorizado','Usuario con el rol no autorizado',{role},403));
    }
 }