package info.esdata {
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import info.esdata.Histogram;
    
    public class DoubleSwitch extends Sprite {
        
        public var _h1 : Histogram;
        public var _h2 : Histogram;
        
        private var _txt1 : TextField = new TextField();
        private var _txt2 : TextField = new TextField();
        private var _label1 : String;
        private var _label2 : String;
        private var _boton1 : Sprite = new Sprite();
        private var _boton2 : Sprite = new Sprite();
        public var leyenda1 : Shape = new Shape(); // Cuadrito con color respectivo
        public var leyenda2 : Shape = new Shape(); // Cuadrito con color respectivo
        private var _selectedLabel : String;
        private static const  SELECTED_BACKGROUND_COLOR : uint = 0xDDDDDD;
        private static const MOUSEOVER_BACKGROUND_COLOR : uint = 0xCCCCCC;
        private static const MOUSEDOWN_BACKGROUND_COLOR : uint = 0xAAAAAA;
        
        public function DoubleSwitch(h1:Histogram, label1:String,
                                     h2:Histogram, label2:String ) {
            _h1 = h1;
            _h2 = h2;
            _label1 = label1;
            _label2 = label2;
            
            addChild(_boton1);
            addChild(_boton2);
            _boton1.addChild(_txt1);
            _boton2.addChild(_txt2);
            _boton1.addChild(leyenda1);
            _boton2.addChild(leyenda2);
            
            // Rectangulo con rayas de las no publicadas
            leyenda1.graphics.lineStyle(1);
            leyenda1.graphics.beginFill(Irreversible.COLOR_ESCONDIDAS); 
            leyenda1.graphics.drawRect(63,10,20,20);
            leyenda1.graphics.lineStyle(0, 0x0, 0.5, false, "normal", "round");
            leyenda1.graphics.moveTo(73,10);
            leyenda1.graphics.lineTo(83,15);
            leyenda1.graphics.moveTo(63,10);
            leyenda1.graphics.lineTo(83,20);
            leyenda1.graphics.moveTo(63,15);
            leyenda1.graphics.lineTo(83,25);
            leyenda1.graphics.moveTo(63,20);
            leyenda1.graphics.lineTo(83,30);
            leyenda1.graphics.moveTo(63,25);
            leyenda1.graphics.lineTo(73,30);
            leyenda1.graphics.endFill();
            // Sobreado transparente sobre fondo de rayas
            leyenda1.graphics.beginFill(Irreversible.COLOR_PUBLICADAS,.2);
            leyenda1.graphics.lineStyle(0,0,0); // Sin borde
            leyenda1.graphics.moveTo(63,10);
            leyenda1.graphics.lineTo(63,30);
            leyenda1.graphics.lineTo(83,30);
            leyenda1.graphics.endFill();
            
            // Rectangulo Publicadas
            leyenda2.graphics.lineStyle(1);
            leyenda2.graphics.beginFill(Irreversible.COLOR_PUBLICADAS);
            leyenda2.graphics.drawRect(63,32,20,20);
            leyenda2.graphics.endFill();
            // Sobreado transparente
            leyenda2.graphics.beginFill(Irreversible.COLOR_ESCONDIDAS,.2); 
            leyenda2.graphics.lineStyle(0,0,0); // Sin borde
            leyenda2.graphics.moveTo(63,32);
            leyenda2.graphics.lineTo(63,52);
            leyenda2.graphics.lineTo(83,52);
            leyenda2.graphics.endFill();
            
            var textFormat:TextFormat = new TextFormat();
            textFormat.font = "Eurostile";
            textFormat.size = 16;

            _txt1.autoSize = "left";
            _txt1.text = _label1;
            _txt1.setTextFormat(textFormat);
            _txt1.y = 10;
            _txt1.x = 85;
            _txt1.addEventListener( MouseEvent.MOUSE_OVER, txtMouseOverHandler);
            _txt1.addEventListener( MouseEvent.MOUSE_OUT , txtMouseOutHandler );
            _txt1.addEventListener( MouseEvent.MOUSE_DOWN, txtMouseDownHandler);
            _txt1.addEventListener( MouseEvent.MOUSE_UP  , txtMouseUpHandler  );
            
            _txt2.autoSize = "left";
            _txt2.text = _label2;
            _txt2.setTextFormat(textFormat);
            _txt2.y = 32;
            _txt2.x = 85;
            _txt2.addEventListener( MouseEvent.MOUSE_OVER, txtMouseOverHandler);
            _txt2.addEventListener( MouseEvent.MOUSE_OUT , txtMouseOutHandler );
            _txt2.addEventListener( MouseEvent.MOUSE_DOWN, txtMouseDownHandler);
            _txt2.addEventListener( MouseEvent.MOUSE_UP  , txtMouseUpHandler  );
        }
        
        
        private function txtMouseOverHandler(mouseEvent:MouseEvent) : void {
            mouseEvent.target.background = true;
            mouseEvent.target.backgroundColor = MOUSEOVER_BACKGROUND_COLOR;
        }
        
        
        private function txtMouseOutHandler(mouseEvent:MouseEvent) : void {
            if (mouseEvent.target.text == _selectedLabel){
                mouseEvent.target.backgroundColor = SELECTED_BACKGROUND_COLOR;
            }
            else {
                mouseEvent.target.background = false;
            }
        }
        
        
        private function txtMouseDownHandler(mouseEvent:MouseEvent) : void {
            mouseEvent.target.backgroundColor = MOUSEDOWN_BACKGROUND_COLOR;
        }
        
        
        private function txtMouseUpHandler(mouseEvent:MouseEvent) : void {
            select(mouseEvent.target.text);         
        }
        
        
        public function select(label:String) : void {          
            if (label == _label1){
                _selectedLabel = _label1;
                _txt1.background = true;
                _txt1.backgroundColor = SELECTED_BACKGROUND_COLOR;
                _txt1.border = true;
                _txt2.border = false;
                _txt2.background = false;
                (this.parent as Irreversible).h1onTop();
            }
            else if (label == _label2) {
                _selectedLabel = _label2;
                _txt2.background = true;
                _txt2.backgroundColor = SELECTED_BACKGROUND_COLOR;
                _txt2.border = true;
                _txt1.border = false;
                _txt1.background = false;
                (this.parent as Irreversible).h2onTop();
            }
            else {
                trace("Unexpected situation");
            }
        }
    }
}
