
import 'environment/flavor_config.dart';
import 'main.dart';

void main() {
  FlavorConfig.appFlavor = Flavor.prod; //set flavor to prod
  initApp();
}
