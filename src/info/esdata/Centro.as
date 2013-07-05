package info.esdata {

    public class Centro {
        private static var _centros : Object = new Object();

        public function Centro() {
        } 
        
        public static function Nombre(cod_centro:String) : String {
            return _centros[ "key" + cod_centro ] ;
        }
                
        public static function add(id_cne:String, name:String) : void {            
            if ( id_cne.length != 9) throw new Error("Invalid Voting Center ID");
            _centros[ "key" + id_cne ] = name;
        }
        
    }
}
