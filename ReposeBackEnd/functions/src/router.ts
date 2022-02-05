import { Application } from "express";

import { registro } from './controllers/autentificacion.controller';

import {createsitios, listsitios,consultarsitios} from './controllers/sitios_controllers';
export function routesPatrion(app: Application){
    
    app.get('/api/sitios', listsitios);    
    app.post('/api/sitios', createsitios);
    app.get('/api/sitios/:id', consultarsitios);
    app.post('/api/registro', registro);

}