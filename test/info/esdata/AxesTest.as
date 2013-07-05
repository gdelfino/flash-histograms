package info.esdata {

	import asunit.framework.TestCase;

	public class AxesTest extends TestCase {
		private var axes:Axes;

		public function AxesTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			axes = new Axes();
		}

		override protected function tearDown():void {
			super.tearDown();
			axes = null;
		}

		public function testInstantiated():void {
			assertTrue("axes is Axes", axes is Axes);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}