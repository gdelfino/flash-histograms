package info.esdata {

	import asunit.framework.TestCase;

	public class EnlacesTest extends TestCase {
		private var enlaces:Enlaces;

		public function EnlacesTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			enlaces = new Enlaces();
		}

		override protected function tearDown():void {
			super.tearDown();
			enlaces = null;
		}

		public function testInstantiated():void {
			assertTrue("enlaces is Enlaces", enlaces is Enlaces);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}