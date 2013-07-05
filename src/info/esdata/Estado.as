package info.esdata {
    
    
    public class Estado {
        private static var estados : Object = new Object();
        
        public function Estado() {
        }
        
        public static function Nombre(cod_centro:String) : String {
            return estados[ "key" + cod_estado(cod_centro) ] ;
        }
        
        public static function cod_estado( cod_centro:String ) : String {
            return cod_centro.substr(0,2);
        }
        
        public static function add(id_cne:String, name:String) : void {
            if (       id_cne.length != 2) throw new Error("Invalid State ID");
            estados[ "key" + id_cne ] = name;
        }
        
    }
}
