import express from "express";
import dotenv from "dotenv";
import { databaseQuery } from "./src/config/db.js";
import cors from "cors";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/alunos', async (req, res) => {
    const alunos = await databaseQuery('SELECT * FROM Alunos');
    res.status(200).send(alunos.rows)
})

app.post('/alunos', async (req, res) => {
    const { mat, nome, endereco, cidade } = req.body;
    const query = `INSERT INTO Alunos (mat, nome, endereco, cidade) VALUES ('${mat}', '${nome}', '${endereco}', '${cidade}')`
    const alunos = await databaseQuery(query);
    res.status(200).send(alunos.rows)
})

app.delete('/alunos/:mat', async (req, res) => {
    const { mat } = req.params;
    const query = `DELETE FROM Alunos WHERE mat=${mat} RETURNING *`
    await databaseQuery(query);
    res.status(200).send(`deleted: ${mat}`);
})

function paramFormat(paramsList){
    const params = paramsList.reduce((result, param) => {
        if(!param) return result;
        if(typeof param==='string'){ return `${param.constructor.name}='${param}' `}
        return result += `${param.constructor.name}=${param} `
    }, '')
    return params;
}

app.put('/alunos', async (req, res) => {
    const { 
        mat = null, 
        nome = null, 
        endereco = null, 
        cidade = null 
    } = req.body;

    // const formatted = paramFormat([mat, nome, endereco, cidade])
    // console.log(formatted);

    const query = `UPDATE Alunos SET nome='${nome}', endereco='${endereco}', cidade='${cidade}' WHERE mat=${mat}`
    console.log(req.body, query);
    const response = await databaseQuery(query);
    res.status(200).send({message: `altered: ${mat}`, log: response});
})



app.listen(3001, async () => {
    console.log("Server Running...");
});