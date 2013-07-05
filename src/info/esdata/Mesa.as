package info.esdata {    
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.events.KeyboardEvent;
    import flash.geom.ColorTransform;
    /*import flash.geom.Point;*/
    import flash.utils.Timer;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import info.esdata.Enlaces;
    import info.esdata.BinColumn;
    
        
    public class Mesa extends Sprite {
        private var _timer : Timer = new Timer(500); // Para que la mesa seleccionada titilee cada medio segundo
        private var _binCount : uint;                // Es como el numerod e escalon. Necesario para saber que tan alto hay que dibujar la mesa.
        private var _selected : Boolean = false;     // True cuando el usuario hace click sobre la mesa.
        private var _encendida : Boolean = false;    // Cuando la mesa esta seleccionada, _encendida alterna entre true y false cada 500 ms
        private var _binHeight : Number = 1;         // Altuda de las mesas en pixel/count.
        private var _percentage : Number;            // Porcentaje de oficialismo 2006.
        private var _cod_centro : String;            // Código nuevo del centro de votación.
        private var _voting_table_number : uint;     // Número de la mesa.
        private static const SELECTED_COLOR : uint = 0xFF0000;
        private static const    HOVER_COLOR : uint = 0xEE0000;
        private var _zoom : Shape;
        
        public function Mesa(percentage:Number,
                             voting_table_number:int,
                             cod_centro:String,
                             c:BinColumn,
                             binCount:uint) {
            _binCount = binCount;
            _percentage = percentage;
            _cod_centro = cod_centro;
            _voting_table_number = voting_table_number;
            var ytop    : Number = c.ejes.convertY( ( _binCount + 1 ) * _binHeight);
            var yheight : Number = c.ejes.convertHeight( _binHeight );
            // Caja 0xFFFF66
            graphics.beginFill(c.ejes.boxColor, 1);
            graphics.drawRect( c.xmin, ytop, c.ancho, yheight );
            graphics.endFill();

            // Linea inclinada
            if (c.ejes.estilo == "con rayas"){
                graphics.lineStyle(0, 0x0, 0.5, false, "normal", "round");
                graphics.moveTo(c.xmin          , ytop           );
                graphics.lineTo(c.xmin + c.ancho, ytop + yheight );                
            }
            addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler );
            addEventListener(MouseEvent.MOUSE_OUT,  mouseOutHandler  );
            addEventListener(MouseEvent.CLICK,      mouseClickHandler);
            addEventListener(KeyboardEvent.KEY_UP,  keyHamdler);
            
            buttonMode = true;
            _timer.start();
        }
        
        
        internal function desmarcarMesa(motivo:String = null) : void {
            _selected = false;
            removeChild( getChildByName("selectMark") );
            _timer.removeEventListener(TimerEvent.TIMER, onTimer);
            Enlaces.borrarEnlaces();
            if (motivo == "cambiando set"){
                top.erraseLabels();                
            }
        }
        
        
        private function mouseOverHandler(mouseEvent:MouseEvent) : void {
            var c : BinColumn = this.parent as BinColumn;
            // Cuadrito del mismo tamaño del original pero rojo
            var selectMark : Sprite = new Sprite();
            selectMark.graphics.beginFill(0xFF0000, 1);
            selectMark.graphics.drawRect( c.xmin, ytop, c.ancho, yheight );
            selectMark.graphics.endFill();
            selectMark.name = "selectMark"
            selectMark.mouseEnabled = false;
            selectMark.alpha = 0.9;
            addChild(selectMark);
            top.setLabels(_cod_centro, _voting_table_number, _percentage);

            // Linea Horizontal
            histogram.lineMark.graphics.clear();
            histogram.lineMark.graphics.lineStyle(0, 0x0, 0.4, false);
            histogram.lineMark.graphics.moveTo(c.xmin + c.ancho / 2, c.ymax);
            if (histogram.estilo == "con rayas"){
                histogram.lineMark.graphics.lineTo(histogram.convertX(100), c.ymax);
            }
            else {
                histogram.lineMark.graphics.lineTo(histogram.convertX(0), c.ymax);
            }
            // Lineas verticales
            histogram.lineMark.graphics.moveTo(c.xmin          , c.ymax     );
            histogram.lineMark.graphics.lineTo(c.xmin          , c.ymin + 16);
            histogram.lineMark.graphics.moveTo(c.xmin + c.ancho, c.ymax     );
            histogram.lineMark.graphics.lineTo(c.xmin + c.ancho, c.ymin + 16);
            
            // Texto
            histogram.lineMarkTextL.autoSize = TextFieldAutoSize.RIGHT;
            histogram.lineMarkTextL.y = c.ymin + 10;
            histogram.lineMarkTextL.x = c.xmin - histogram.lineMarkTextL.width;
            histogram.lineMarkTextL.text = c.minInclusive + "%→";
            
            histogram.lineMarkTextR.autoSize = TextFieldAutoSize.LEFT;  
            histogram.lineMarkTextR.y = c.ymin + 10;
            histogram.lineMarkTextR.x = c.xmax;
            histogram.lineMarkTextR.text = "←" + c.maxNonInclusive + "%";
        }
        
        
        private function mouseOutHandler(mouseEvent:MouseEvent) : void {
            if (!_selected){
                removeChild(getChildByName("selectMark"));
            }
        }
        
        
        private function mouseClickHandler(mouseEvent:MouseEvent) : void {
            _selected = true;
            if ( histogram.selectedBinItem != null ){
                 histogram.selectedBinItem.desmarcarMesa();
            }
            histogram.selectedBinItem = this;            
            top.setLabels(_cod_centro, _voting_table_number, _percentage);
            _timer.addEventListener(TimerEvent.TIMER, onTimer);
            
            var c : BinColumn = this.parent as BinColumn;
            _zoom = new Shape();
            _zoom.x = c.xmin;
            _zoom.y = ytop;
            _zoom.graphics.lineStyle(0, 0x0, 0.5, false, "normal", "round");
            _zoom.graphics.drawRect( 0, 0, c.ancho, yheight );
            addChild(_zoom);
            _zoom.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
        
        private function onEnterFrame(event:Event) : void {
            var c : BinColumn = this.parent as BinColumn;
            var easing  : Number = 0.1;
            var targetX : Number = 30;  // TODO: Use variable in Enlaces.as
            var targetY : Number = 165; // TODO: Use variable in Enlaces.as
            var targetW : Number = 200;
            var targetH : Number = 60;
            
            _zoom.x      += (targetX - c.xmin  ) * easing;
            _zoom.y      += (targetY - ytop    ) * easing;
            _zoom.width  += (targetW - c.ancho ) * easing;
            _zoom.height += (targetH - yheight ) * easing;
            
            if ( Math.abs(_zoom.x - targetX) < 1 && Math.abs(_zoom.y - targetY) < 1 ) {
                _zoom.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                _zoom.graphics.clear();
                _zoom = null
                Enlaces.mostrarEnlaces(_cod_centro, _voting_table_number, this.parent as Sprite);
            }
            
        }
        
        private function onTimer(event:TimerEvent) : void {
            _encendida = !_encendida;
            getChildByName("selectMark").alpha = _encendida ? 0.9 : 0.3;
            event.updateAfterEvent();
        }
        
        
        // Este método se utiliza en Histograma.as
        public function get cod_centro() : String {
            return _cod_centro;
        }
        
        
        // Este método se utiliza en Histograma.as
        public function get voting_table_number() : uint {
            return _voting_table_number;
        }

        private function get histogram() : Histogram {
            return (this.parent.parent as Histogram)
        }
        
        private function get yheight() : Number { 
            return histogram.convertHeight( _binHeight ); 
        }
        
        private function get ytop() : Number {
            return histogram.convertY( ( _binCount + 1 ) * _binHeight);
        }        
        
        private function get top() : Irreversible {
            return (this.parent.parent.parent as Irreversible)
        }
        
        public function get percentage() : Number { 
            return _percentage; 
        }        
        
        private function keyHamdler(keyEvent:KeyboardEvent) : void {
            switch (keyEvent.keyCode){
                case 37 : trace("left") ; break;
                case 38 : trace("up")   ; break;
                case 39 : trace("right"); break;
                case 40 : trace("down") ; break;
            }
        }
        
    }
}
