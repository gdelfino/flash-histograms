package info.esdata {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.text.AntiAliasType;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.system.Security;
    
    /*import flash.system.ApplicationDomain;*/
    
    import flash.utils.Dictionary;
    
    import info.esdata.Histogram;
    import info.esdata.Estado;
    import info.esdata.Municipio;
    import info.esdata.Centro;
    
    
    public class DataLoader extends Sprite{
        
        private var _loader : URLLoader;

        private var _h1 : Histogram;
        private var _h2 : Histogram;
        private var _percentageLoaded : TextField  = new TextField();
        private var           _format : TextFormat = new TextFormat(); 
        
        [Embed(source='/Library/Fonts/Impact.ttf', fontFamily='Impact')]
        private var impact : Class;
        
        
        public function DataLoader(h1:Histogram, h2:Histogram) {     
            /*trace("domain = " + ApplicationDomain.currentDomain.toString())       */
            _h1 = h1;
            _h2 = h2;

            _format.font = "Impact";
            _format.size = 256;

            _percentageLoaded.autoSize = TextFieldAutoSize.CENTER;
            _percentageLoaded.defaultTextFormat = _format;  
            _percentageLoaded.embedFonts = true;            
            _percentageLoaded.text = "0 %";
            _percentageLoaded.x = 907 / 2 - _percentageLoaded.width/2;
            _percentageLoaded.y = 590 / 2 - _percentageLoaded.height/2;
            alpha = 0.1;
            
            this.addChild(_percentageLoaded);
        }
        
        
        public function loadData(url:String) : void {
            /*Security.loadPolicyFile("/Users/gdelfino/Sites/esdata/rails/esdata/public/crossdomain.xml");*/
            var request : URLRequest = new URLRequest(url);
            _loader = new URLLoader(request);
            _loader.addEventListener(        Event.ACTIVATE, activatedListener);
            _loader.addEventListener(ProgressEvent.PROGRESS, progressListener );
            _loader.addEventListener(        Event.COMPLETE, completeListener );            
        }
        
        
        private function activatedListener(event:Event) : void {
            trace(" activated " + _loader.bytesLoaded + " but nothing loaded yet.");
        }
        
        
        private function completeListener(event:Event) : void {
            trace(" all done loading " );
            _percentageLoaded.text = "Dibujando Histogramas";
            
            if (_loader.data){
                var myXML : XML = XML(_loader.data);

                var estadosData : XMLList = myXML.states.state;
                for each (var e:XML in estadosData){
                    Estado.add(e.id_cne,  e.name);
                }

                var municipiosData : XMLList = myXML.counties.county;
                for each (var m:XML in municipiosData){
                    Municipio.add(m.state_id_cne, m.id_cne,  m.name);
                }

                var parroquiasData : XMLList = myXML.townships.township;
                for each (var p:XML in parroquiasData){
                    Parroquia.add(p.state_id_cne, p.county_id_cne, p.id_cne,  p.name);
                }

                var centrosData : XMLList = myXML.centers.center;
                for each (var c:XML in centrosData){
                    Centro.add(c.id_cne,  c.name);
                }

                var mesa:XML;
                var excluidas:XMLList = myXML.excluidas.mesa;
                for each (mesa in excluidas){
                    _h1.addVotingTable( mesa.porcentaje_oficialista,
                                        mesa.numero,
                                        mesa.cod_centro
                     );
                }
                
                var incluidas:XMLList = myXML.incluidas.mesa;
                for each (mesa in incluidas){
                    _h2.addVotingTable( mesa.porcentaje_oficialista,
                                        mesa.numero,
                                        mesa.cod_centro
                     );
                }                
            }
            removeChild(_percentageLoaded);
        }
        
        
        private function progressListener(event:Event) : void {
            /*trace(" we are in progress, we have loaded " + _loader.bytesLoaded + " out of " + _loader.bytesTotal + " bytes");*/
            /*_percentageLoaded.text= (100 * _loader.bytesLoaded / _loader.bytesTotal).toFixed(0) + " %";*/
            _percentageLoaded.text= (100 * _loader.bytesLoaded / 6686517).toFixed(0) + " %";
        }
        
    }
}
