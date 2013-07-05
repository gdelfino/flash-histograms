package info.esdata {
    import info.esdata.Estado;
    import info.esdata.Municipio;

    public class Parroquia {
        private static var parroquias : Object = new Object();

        public function Parroquia() {
        } 
        
        public static function Nombre(cod_centro:String) : String {
            return parroquias[ "key" + Estado.cod_estado(cod_centro) + Municipio.cod_municipio(cod_centro) + cod_parroquia(cod_centro) ] ;
        }
        
        public static function cod_parroquia( cod_centro:String ) : String {
            return cod_centro.substr(4,2);
        }
        
        public static function add(state_id_cne:String, county_id_cne:String, id_cne:String, name:String) : void {            
            if ( state_id_cne.length != 2) throw new Error("Invalid State ID");
            if (county_id_cne.length != 2) throw new Error("Invalid County ID");
            if (       id_cne.length != 2) throw new Error("Invalid Township ID");
            parroquias[ "key" + state_id_cne + county_id_cne + id_cne ] = name;
        }
        
    }
}
