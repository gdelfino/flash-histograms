package info.esdata {
    
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;
    
    public class EtiquetaDinamica extends Sprite{
        
        private        var _labelName        : TextField  = new TextField();
        private        var _labelValue       : TextField  = new TextField();
        private static var _labelNameFormat  : TextFormat = new TextFormat();
        private static var _labelValueFormat : TextFormat = new TextFormat();
        
        public function EtiquetaDinamica(x:uint, y:uint, label:String) {
            _labelNameFormat.font = "_sans";
            _labelNameFormat.size = 10;
            _labelNameFormat.align = TextFormatAlign.LEFT;
            _labelNameFormat.bold = true;
            
            _labelValueFormat.font = "_sans";
            _labelValueFormat.size = 10;
            _labelValueFormat.align = TextFormatAlign.LEFT;
            
            _labelName.x = x;
            _labelName.y = y;
            _labelName.autoSize = TextFieldAutoSize.LEFT;
            _labelName.defaultTextFormat = _labelNameFormat;
            _labelName.text = label;

            addChild(_labelName);
            addChild(_labelValue);
        } 
        
        public function setLabelValue(labelText:String) : void {
            _labelValue.x = _labelName.x + _labelName.width;
            _labelValue.y = _labelName.y;
            _labelValue.autoSize = TextFieldAutoSize.LEFT;
            _labelValue.defaultTextFormat = _labelValueFormat;
            _labelValue.text = labelText;
        }
    }
}
