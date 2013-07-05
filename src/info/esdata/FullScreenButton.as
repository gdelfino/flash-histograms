package info.esdata {
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.display.StageDisplayState;
    
    public class FullScreenButton extends Sprite {
        
        public function FullScreenButton(xPos:uint, yPos:uint) {
            graphics.lineStyle(1, 0x7E7E7E, 1, true, "normal", "round");
            graphics.beginFill(0xDDDDDD,1);
            graphics.drawRoundRect(xPos, yPos, 22, 16,7);
            graphics.endFill();

            graphics.lineStyle(1, 0x0, 1, true, "normal", "round");
            graphics.beginFill(0x6B6B6B,1);
            graphics.drawRect(xPos+3, yPos+3, 10, 7);
            graphics.endFill();
            
            addEventListener(MouseEvent.CLICK,      mouseClickHandler);
            buttonMode = true;
        }
        
        private function mouseClickHandler(mouseEvent:MouseEvent) : void {
            if (stage.displayState == StageDisplayState.FULL_SCREEN){
                stage.displayState = StageDisplayState.NORMAL;    
            }
            else {
                stage.displayState = StageDisplayState.FULL_SCREEN
            }
        }
        
    }
}
