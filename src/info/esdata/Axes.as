package info.esdata {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;
    
    public class Axes extends Sprite {
        public var xmin        : Number =   0;
        public var xmax        : Number = 100;
        public var ymin        : Number =   0;
        public var ymax        : Number =  10;
        public var boxWidth       : int = 841;
        public var boxHeight      : int = 560;
        public var padding_left   : int =  15;
        public var padding_right  : int =  10;
        public var padding_top    : int =  0;
        public var padding_bottom : int =  15;
        public var verticalAxisLocation : String = 'left'; // left or right
        
        [Embed(source='/Library/Fonts/Verdana.ttf', fontFamily='Verdana')]
        private var verdana : Class;
        
        public function Axes() {
            super();
            x = 33;
            y = 5;
        }
        
        public function drawAxes() : void {
            /* Draw axes lines */
            graphics.lineStyle(1);
            if (verticalAxisLocation == 'left'){
                graphics.moveTo( padding_left,             padding_top    );
                graphics.lineTo( padding_left, boxHeight - padding_bottom );                
            }
            else {
                graphics.moveTo( boxWidth - padding_right ,             padding_top    );
                graphics.lineTo( boxWidth - padding_right , boxHeight - padding_bottom );               
            }
            
            graphics.moveTo(            padding_left , boxHeight - padding_bottom );
            graphics.lineTo( boxWidth - padding_right, boxHeight - padding_bottom );
            drawYticks();
            drawXticks();
        }
        
        public function xlabel(s:String) : void {
            var fontFormat : TextFormat = new TextFormat();
            fontFormat.font = "Verdana";
            fontFormat.size = 14;
            
            var t : TextField = new TextField();
            t.defaultTextFormat = fontFormat;
            t.embedFonts = true;
            t.antiAliasType = AntiAliasType.ADVANCED;
            t.autoSize = TextFieldAutoSize.CENTER;
            t.text = " " + s + " ";
            t.y = boxHeight - padding_bottom / 2 + 12;
            t.x = convertX( (xmax-xmin) / 2 ) - t.width/2;
            addChild(t);
        }

        public function ylabel(s:String) : void {
            var fontFormat : TextFormat = new TextFormat();
            fontFormat.font = "Verdana";
            fontFormat.size = 14;
            
            var t : TextField = new TextField();
            t.defaultTextFormat = fontFormat;
            t.embedFonts = true;
            t.antiAliasType = AntiAliasType.ADVANCED;
            t.autoSize = TextFieldAutoSize.CENTER;
            t.text = s;
            t.rotation = -90;
            t.y =    boxHeight / 2 + t.height / 2;
            if (verticalAxisLocation == 'left'){
                t.x =             padding_left / 2 - t.width  / 2 - 25;
            }
            else {
                t.x = boxWidth - padding_right / 2 - t.width  / 2 + 20;
            }
            addChild(t);
        }
        
        public function drawYticks() : void {
            var fontFormat : TextFormat = new TextFormat();
            fontFormat.font = "Verdana";
            fontFormat.size = 8;
            
            for ( var y:Number = ymin; y <= ymax; y = y + 10 ){
                graphics.lineStyle(0, 0x000000);
                var t : TextField = new TextField();
                t.defaultTextFormat = fontFormat;
                t.embedFonts = true;
                t.antiAliasType = AntiAliasType.ADVANCED;
                
                if (verticalAxisLocation == 'left'){
                    t.autoSize = TextFieldAutoSize.RIGHT;
                    t.x = convertX(xmin) - 6;
                    t.y = convertY(y);
                    graphics.moveTo( convertX(xmin) - 2, convertY(y) );
                    graphics.lineTo( convertX(xmin)    , convertY(y) );
                }
                else {
                    t.autoSize = TextFieldAutoSize.LEFT;
                    t.x = convertX(xmax) + 2;
                    t.y = convertY(y);
                    graphics.moveTo( convertX(xmax) + 2, convertY(y) );
                    graphics.lineTo( convertX(xmax)    , convertY(y) );
                }
                t.text = y.toString();
                t.y -= t.height/2;
                addChild(t);
            }
        }

        public function drawXticks() : void {
            var fontFormat : TextFormat = new TextFormat();
            fontFormat.font = "Verdana";
            fontFormat.size = 8;
            
            for ( var x:Number = xmin; x <= xmax; x = x + ( xmax - xmin ) / 10 ){
                graphics.lineStyle(0, 0x000000);
                graphics.moveTo( convertX(x), convertY(ymin) + 3 );
                graphics.lineTo( convertX(x), convertY(ymin)     );
                
                var t : TextField = new TextField();
                t.defaultTextFormat = fontFormat;
                t.embedFonts = true;
                t.antiAliasType = AntiAliasType.ADVANCED;
                t.autoSize =  TextFieldAutoSize.CENTER;
                t.x = convertX(x);
                t.y = convertY(ymin) + 2;
                t.text = x.toString()+"%";
                t.x -= t.width / 4;
                addChild(t);
            }
        }
        
        
        public function convertX(x:Number) : Number {
            return ((x - xmin) / (xmax - xmin)) * (boxWidth - padding_left - padding_right) + padding_left;
        }
        
        public function convertWidth(x:Number) : Number {
            return          (x / (xmax - xmin)) * (boxWidth - padding_left - padding_right);
        }
        
        public function convertY(y:Number) : Number {
            return ((ymax - y) / (ymax - ymin)) * (boxHeight - padding_top - padding_bottom) + padding_top;
        }
        
        public function convertHeight(y:Number) : Number {
            return          (y / (ymax - ymin)) * (boxHeight - padding_top - padding_bottom);
        }
    }
}
