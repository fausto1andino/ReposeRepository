import { Application } from "express";
//import {list, listsitios, createsitios, consultarsitios } from './controllers/sitios_controllers';
import { list } from './controllers/sitios_controllers';
export function routesPatrion(app: Application){
    app.get('/api/sitios', list);  
    /*app.get('/api/sitios/', listsitios);    
    app.post('/api/sitios', createsitios);
    app.get('/api/sitios/:id', consultarsitios);*/
}