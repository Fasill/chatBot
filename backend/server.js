import express from 'express';
import router from './router/chatbotRouter.js';
import cors from 'cors';
const app = express();

app.use(cors());

app.use(express.json());

app.use('/', router);


const port = 8080;
app.listen(port, () => console.log(`Server listening on port ${port}`));
