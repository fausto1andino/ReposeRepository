import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as express from "express";
import * as bodyPaser from "body-parser";
import * as cors from "cors";
import { routesPatrion } from "./router";

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();
db.settings({ignoreUndefinedProperties : true, timestampsInSnapshot: true});



const server = express();
server.use(cors({origin: true}));
server.use(bodyPaser.json());
server.use(bodyPaser.urlencoded({extended: false}));


routesPatrion(server);

export {db};
export const api = functions.https.onRequest(server);

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
