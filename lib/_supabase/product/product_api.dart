import 'package:supabase/supabase.dart';
import 'package:vet_app/config/variables_supabase.dart';

class ProductApi {
  final supabaseClient = SupabaseClient(urlSupa!, keySupa!);

  Future<void> addProductSale(
      double price, int petloverId, int establishmentId) async {
    final response = await supabaseClient.from('product_sale').insert([
      {
        'establishment_id': establishmentId,
        'petlover_id': petloverId,
        'price': price,
      }
    ]).execute();

    final dato = response.data as List;
    print(dato);
  }

  Future<void> addProductSaleDetail(String name, double price, int quantity,
      int productTypeId, String productSaleId) async {
    final response = await supabaseClient.from('product_sale_detail').insert([
      {
        'name': name,
        'price': price,
        'quantity': quantity,
        'product_type_id': productTypeId,
        'product_sale_id': productSaleId,
      }
    ]).execute();

    final dato = response.data as List;
    print(dato);
  }

  Future<void> getSales(int id) async {
    final response = await supabaseClient
        .from('product_sale')
        .select()
        .eq('establishment_id', id)
        .execute();

    final dato = response.data as List;
    print(dato);
  }

  Future<void> getProductType() async {
    final response =
        await supabaseClient.from('product_type').select().execute();

    final dato = response.data as List;
    print(dato);
  }
}