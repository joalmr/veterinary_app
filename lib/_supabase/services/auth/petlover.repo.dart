import 'package:vet_app/_supabase/services/auth/petlover.api.dart';

class PetloverRepo {
  final _api = PetloverApi();

  Future<int> getPetlover(String uuidPetlover, String name, String lastname) {
    return _api.getPetlover(uuidPetlover, name, lastname);
  }
}
