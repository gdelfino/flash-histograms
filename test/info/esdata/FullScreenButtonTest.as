package info.esdata {

	import asunit.framework.TestCase;

	public class FullScreenButtonTest extends TestCase {
		private var instance:FullScreenButton;

		public function FullScreenButtonTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new FullScreenButton();
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is FullScreenButton", instance is FullScreenButton);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}