import { pool } from '../db.js';
export class ProductRepository {
    async create(p) {
        const conn = await pool.getConnection();
        try {
            const [result] = await conn.execute(`INSERT INTO products (sku, name, description, price, quantity) VALUES (?, ?, ?, ?, ?)`, [p.sku, p.name, p.description ?? null, p.price, p.quantity]);
            // @ts-ignore - mysql2 typing
            const id = result.insertId;
            const created = await this.getById(id);
            if (!created)
                throw new Error('Insert succeeded but could not read back record');
            return created;
        }
        finally {
            conn.release();
        }
    }
    async getById(id) {
        const [rows] = await pool.execute(`SELECT * FROM products WHERE id = ?`, [id]);
        const arr = rows;
        return arr[0] ?? null;
    }
    async getBySku(sku) {
        const [rows] = await pool.execute(`SELECT * FROM products WHERE sku = ?`, [sku]);
        const arr = rows;
        return arr[0] ?? null;
    }
    async updateById(id, patch) {
        const fields = [];
        const values = [];
        for (const [k, v] of Object.entries(patch)) {
            if (v === undefined)
                continue;
            fields.push(`${k} = ?`);
            values.push(v);
        }
        if (fields.length === 0)
            return this.getById(id);
        values.push(id);
        await pool.execute(`UPDATE products SET ${fields.join(', ')} WHERE id = ?`, values);
        return this.getById(id);
    }
    async deleteById(id) {
        const [res] = await pool.execute(`DELETE FROM products WHERE id = ?`, [id]);
        // @ts-ignore
        return res.affectedRows > 0;
    }
    async list(limit = 50, offset = 0) {
        // Interpolate limit and offset directly to avoid MySQL parameter error
        const safeLimit = Number.isInteger(limit) && limit > 0 ? limit : 50;
        const safeOffset = Number.isInteger(offset) && offset >= 0 ? offset : 0;
        const [rows] = await pool.query(`SELECT * FROM products ORDER BY id DESC LIMIT ${safeLimit} OFFSET ${safeOffset}`);
        return rows;
    }
    async searchByName(q, limit = 50, offset = 0) {
        const like = `%${q}%`;
        // Interpolate limit and offset directly to avoid MySQL parameter error
        const safeLimit = Number.isInteger(limit) && limit > 0 ? limit : 50;
        const safeOffset = Number.isInteger(offset) && offset >= 0 ? offset : 0;
        const [rows] = await pool.query(`SELECT * FROM products WHERE name LIKE ? ORDER BY id DESC LIMIT ${safeLimit} OFFSET ${safeOffset}`, [like]);
        return rows;
    }
}
