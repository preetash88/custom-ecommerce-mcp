import { z } from 'zod';
import { ProductRepository } from '../repo/ProductRepository.js';
export const ProductCreateSchema = z.object({
    sku: z.string().min(1),
    name: z.string().min(1),
    description: z.string().optional().nullable(),
    price: z.number().nonnegative(),
    quantity: z.number().int().nonnegative(),
});
export const ProductUpdateSchema = z.object({
    id: z.number().int().positive(),
    sku: z.string().min(1).optional(),
    name: z.string().min(1).optional(),
    description: z.string().optional().nullable(),
    price: z.number().nonnegative().optional(),
    quantity: z.number().int().nonnegative().optional(),
});
export class ProductService {
    #repo = new ProductRepository();
    async addProduct(input) {
        const data = ProductCreateSchema.parse(input);
        return this.#repo.create(data);
    }
    async getProductById(id) {
        return this.#repo.getById(id);
    }
    async updateProduct(input) {
        const data = ProductUpdateSchema.parse(input);
        const { id, ...patch } = data;
        return this.#repo.updateById(id, patch);
    }
    async deleteProduct(id) {
        return this.#repo.deleteById(id);
    }
    async listProducts(limit = 50, offset = 0) {
        return this.#repo.list(limit, offset);
    }
    async searchProducts(q, limit = 50, offset = 0) {
        return this.#repo.searchByName(q, limit, offset);
    }
}
