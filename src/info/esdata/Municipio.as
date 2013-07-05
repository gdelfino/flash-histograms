package info.esdata {
    import info.esdata.Estado;

    public class Municipio {
        private static var municipios : Object = new Object();

        public function Municipio() {
        } 
        
        public static function Nombre(cod_centro:String) : String {
            return municipios[ "key" + Estado.cod_estado(cod_centro) + cod_municipio(cod_centro) ] ;
        }
        
        public static function cod_municipio( cod_centro:String ) : String {
            return cod_centro.substr(2,2);
        }
        
        public static function add(state_id_cne:String, id_cne:String, name:String) : void {
            if ( state_id_cne.length != 2) throw new Error("Invalid State ID");
            if (       id_cne.length != 2) throw new Error("Invalid County ID");
            municipios[ "key" + state_id_cne + id_cne ] = name;
        }
        
    }
}
