import { Application } from "express";
import { list } from './controllers/patrocinadores_controllers';

export function routesPatrion(app: Application){
    app.get('/api/sitios', list);
}