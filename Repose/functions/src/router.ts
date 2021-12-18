import { Application } from "express";
import { list } from './controllers/lugaresT_controller';

export function routesSitioT(app: Application){
    app.get('/api/SitiosDeInterezEcuador"', list);
}