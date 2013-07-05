package info.esdata {
    import flash.display.Sprite;
    import info.esdata.Mesa;
    
    public class BinColumn extends Sprite {
        private var _ejes : Histogram;
        private var _minInclusive : Number;
        private var _maxNonInclusive : Number;
        private var _binCount : int = 0;
        private var _boxColor : uint;
        
        public function BinColumn(ejes:Histogram, minInclusive:Number, maxNonInclusive:Number) {
            _ejes = ejes;
            _minInclusive = minInclusive;
            _maxNonInclusive = maxNonInclusive;
            graphics.beginFill(0xFF0000, 1);
            graphics.drawRect( ejes.convertX( _minInclusive ),
                               ejes.convertY( 0 ),
                               ejes.convertWidth( binWidth ),
                               ejes.convertHeight( 0 ) );
            graphics.endFill();
        }
        
        public function addVotingTable(p:Number, voting_table_number:int, cod_centro:String ) : void {
            var m : Mesa = new Mesa(p, voting_table_number, cod_centro, this, _binCount++);
            addChild(m);
        }

        public function get ymax() : Number {
            return _ejes.convertY( _binCount )
        }

        public function get ymin() : Number {
            return _ejes.convertY( 0 )
        }

        public function get xmin() : Number {
            return _ejes.convertX( _minInclusive )
        }
        
        public function get ancho() : Number { 
            return ejes.convertWidth( binWidth ); 
        }

        public function get xmax() : Number {
            return xmin + ancho;
        }

        public function get minInclusive() : Object { 
            return _minInclusive; 
        }
        
        public function get maxNonInclusive() : Object { 
            return _maxNonInclusive; 
        }
        
        public function get ejes() : Object { 
            return _ejes; 
        }
        
        public function get binWidth() : Number { 
            return _maxNonInclusive - _minInclusive; 
        }
                
    }
}
