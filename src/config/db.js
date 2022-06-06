import pg from "pg";

const database = new pg.Pool({
    user: "root",
    password: "root",
    database: "root",
    port: 5432,
    host: "127.0.0.1"
});

async function databaseQuery(query){
    if(!query){return } //TODO Error handling
    
    const client = await database.connect();
    const res = await client.query(query);
    
    await client.release()
    return res;
}

export {
    databaseQuery
};