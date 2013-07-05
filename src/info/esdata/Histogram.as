package info.esdata {
    import flash.events.MouseEvent;
    import flash.display.LineScaleMode;
    import flash.display.GradientType;
    import flash.display.JointStyle;
    import flash.display.Sprite;
    import flash.geom.Matrix;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    import info.esdata.Axes;
    import info.esdata.Mesa;

    public class Histogram extends Axes{
        public var bins : Array  = [];
        public var minBin : Number = 0;
        public var maxBin : Number = 100;
        public var binWidth : Number = 10;
        public var boxColor : uint;
        public var selectedBinItem : Mesa;
        public var estilo : String;
        public var lineMark : Sprite = new Sprite();
        public var lineMarkTextL : TextField = new TextField();
        public var lineMarkTextR : TextField = new TextField();
        
        public function Histogram(minBin:Number, maxBin:Number, binWidth:Number, boxColor:uint, estilo:String) {
            this.minBin = minBin;
            this.maxBin = maxBin;
            this.boxColor = boxColor;
            this.binWidth = binWidth;
            this.estilo = estilo;
            alpha = 0.7;

            // Ahora añadimos las colunas:
            for (var i:Number = minBin; i < maxBin; i = i + binWidth){
                var c : BinColumn = new BinColumn(this, i, i + binWidth);
                addChildBinColumn(c);
            }
            addChild(lineMark);
            lineMark.addChild(lineMarkTextL);
            lineMark.addChild(lineMarkTextR);
            
            
            // Degrades de azul a rojo:
            var mxBox : Matrix = new Matrix();
            mxBox.createGradientBox(boxWidth - padding_left - padding_right, 20);
            graphics.lineStyle(18, 0x0, 1, false, LineScaleMode.NORMAL, "none");
            graphics.lineGradientStyle(GradientType.LINEAR, [0x0000FF, 0xFFFFFF, 0xFF0000], [100,100,100], [0x00,0x7F,0xFF], mxBox);
            graphics.moveTo(             padding_left, boxHeight + 16 );
            graphics.lineTo( boxWidth - padding_right, boxHeight + 16 );
            graphics.endFill();
            
            this.addEventListener(MouseEvent.ROLL_OUT,  rollOutHandler  );
        }

        private function rollOutHandler(mouseEvent:MouseEvent) : void {
            lineMark.graphics.clear();
            lineMarkTextL.text = "";
            lineMarkTextR.text = "";
            if (selectedBinItem == null){
                ( this.parent as Irreversible ).erraseLabels();
            }
            else {
                ( this.parent as Irreversible ).setLabels(selectedBinItem.cod_centro,
                                                          selectedBinItem.voting_table_number,
                                                          selectedBinItem.percentage); 
            }
        }

        public function addChildBinColumn(c:BinColumn) : void {
            addChild(c);
            bins.push(c);
        }

        public function addVotingTable(p:Number,
                                       voting_table_number:int,
                                       cod_centro:String) : void {
            var bn:int = int( p / binWidth );
            if (p == maxBin){ // Para casos en los que el porcentaje es 100 %
                bn = bn - 1;
            }
            bins[bn].addVotingTable( p, voting_table_number, cod_centro);
        }
        
        public function deselectTables() : void {
            trace("deselectTables");
        }
        
        public function deselectActiveBinItem() : void {
            if (selectedBinItem != null){
                selectedBinItem.desmarcarMesa("cambiando set");
                selectedBinItem = null;
            }
        }
    }
}
