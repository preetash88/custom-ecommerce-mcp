export interface Product {
  id?: number;
  sku: string;
  name: string;
  description?: string | null;
  price: number;
  quantity: number;
  created_at?: string;
  updated_at?: string;
}
