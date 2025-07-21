
import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
final class Env{
@EnviedField(varName:"SUPABASEURL",obfuscate: true)
static String supabaseUrl=_Env.supabaseUrl;

@EnviedField(varName:"ANONKEY",obfuscate: true)
static String anonKey=_Env.anonKey;

}