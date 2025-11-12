import 'dotenv/config';
import mysql from 'mysql2/promise';
export const pool = mysql.createPool({
    host: process.env.MYSQL_HOST || 'localhost',
    port: Number(process.env.MYSQL_PORT || 3306),
    user: process.env.MYSQL_USER || '<username',
    password: process.env.MYSQL_PASSWORD || 'user_password',
    database: process.env.MYSQL_DATABASE || 'user_database',
    waitForConnections: true,
    connectionLimit: 10,
    maxIdle: 10,
    idleTimeout: 60000,
    enableKeepAlive: true,
});
