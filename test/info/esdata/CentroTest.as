package info.esdata {

	import asunit.framework.TestCase;

	public class CentroTest extends TestCase {
		private var centro:Centro;

		public function CentroTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			centro = new Centro();
		}

		override protected function tearDown():void {
			super.tearDown();
			centro = null;
		}

		public function testInstantiated():void {
			assertTrue("centro is Centro", centro is Centro);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}