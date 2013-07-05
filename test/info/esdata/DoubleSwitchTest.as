package info.esdata {

	import asunit.framework.TestCase;

	public class DoubleSwitchTest extends TestCase {
		private var instance:DoubleSwitch;

		public function DoubleSwitchTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new DoubleSwitch();
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is DoubleSwitch", instance is DoubleSwitch);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}