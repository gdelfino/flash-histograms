package info.esdata {

	import asunit.framework.TestCase;

	public class HistogramTest extends TestCase {
		private var histogram:Histogram;

		public function HistogramTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			histogram = new Histogram();
		}

		override protected function tearDown():void {
			super.tearDown();
			histogram = null;
		}

		public function testInstantiated():void {
			assertTrue("histogram is Histogram", histogram is Histogram);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}