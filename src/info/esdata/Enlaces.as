package info.esdata {
    import flash.display.Sprite;    
    import flash.display.Shape;    
    
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;
    import flash.events.Event;
    
    public class Enlaces {
        
        private static var _mesa : uint;
        private static var _binColumn : Sprite;
        private static var _txtEsdata  : TextField;
        private static var _txtCNE2006 : TextField;
        private static var _txtCNE2007 : TextField;
        private static var _cod_centro : String;
        private static var _formatoURLs : TextFormat;
        public static const xpos : uint = 30;
        public static const ypos : uint = 165;
        
        public function Enlaces() {
        } 
        
        public static function mostrarEnlaces(cod_centro:String, mesa:uint, binColumn:Sprite) : void {
            _mesa = mesa;
            _binColumn = binColumn;
            _cod_centro =  cod_centro;
            
            _txtEsdata  = new TextField();
            _txtCNE2006 = new TextField();
            _txtCNE2007 = new TextField();
            _formatoURLs = new TextFormat();
            
            _formatoURLs.font = "Verdana";
            _formatoURLs.color = 0x0000FF;
            _formatoURLs.underline = true;
            _formatoURLs.align = TextFormatAlign.LEFT;
            _formatoURLs.size = 10;

            _txtEsdata.defaultTextFormat  = _formatoURLs;
            _txtCNE2006.defaultTextFormat = _formatoURLs;
            _txtCNE2007.defaultTextFormat = _formatoURLs;

            _txtEsdata.embedFonts  = true;
            _txtCNE2006.embedFonts = true;
            _txtCNE2007.embedFonts = true;

            _txtEsdata.antiAliasType  = AntiAliasType.ADVANCED;
            _txtCNE2006.antiAliasType = AntiAliasType.ADVANCED;
            _txtCNE2007.antiAliasType = AntiAliasType.ADVANCED;

            _txtEsdata.autoSize  = TextFieldAutoSize.RIGHT;
            _txtCNE2006.autoSize = TextFieldAutoSize.RIGHT;
            _txtCNE2007.autoSize = TextFieldAutoSize.RIGHT;

            _txtEsdata.htmlText  = "<a target='_blank' href='http://www.esdata.info/centro/" + _cod_centro + "'>Ver este centro en ESDATA</a>";
            _txtCNE2006.htmlText = "<a target='_blank' href='"                            + url_cne_2006() + "'>Verificar resultado 2006 en el CNE</a>";
            _txtCNE2007.htmlText = "<a target='_blank' href='"                            + url_cne_2007() + "'>Ver resultado 2007 en el CNE</a>";

            _txtEsdata.x  = xpos;
            _txtCNE2006.x = xpos;
            _txtCNE2007.x = xpos;

            _txtEsdata.y  = ypos;
            _txtCNE2006.y = ypos + 20;
            _txtCNE2007.y = ypos + 40;

            _binColumn.addChild(_txtEsdata);
            _binColumn.addChild(_txtCNE2006);
            _binColumn.addChild(_txtCNE2007);
        }
        
        
        public static function borrarEnlaces() : void {
            _binColumn.removeChild(_txtEsdata);
            _binColumn.removeChild(_txtCNE2006);
            _binColumn.removeChild(_txtCNE2007);
        }
        
        
        private static function url_cne_2006() : String {
            return "http://cne.gob.ve/divulgacionPresidencial/resultado_nacional.php?color=2&c2=0&" +
            "e=" +    Estado.cod_estado(   _cod_centro) + "&"+
            "m=" + Municipio.cod_municipio(_cod_centro) + "&"+
            "p=" + Parroquia.cod_parroquia(_cod_centro) + "&"+
            "c=" +                         _cod_centro  + "&"+
            "me="+ _mesa
        }


        private static function url_cne_2007() : String {
            return "http://www.cne.gob.ve/divulgacion_referendo_reforma/index.php?" +
               "cod_estado=" +    Estado.cod_estado(   _cod_centro) + "&amp;" + 
            "cod_municipio=" + Municipio.cod_municipio(_cod_centro) + "&amp;" + 
            "cod_parroquia=" + Parroquia.cod_parroquia(_cod_centro) + "&amp;" + 
               "cod_centro=" +                         _cod_centro  + "&amp;" +
                 "num_mesa=" + _mesa;
        }        
    }
}
