package info.esdata {

	import asunit.framework.TestCase;

	public class MesaTest extends TestCase {
		private var mesa:Mesa;

		public function MesaTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			mesa = new Mesa();
		}

		override protected function tearDown():void {
			super.tearDown();
			mesa = null;
		}

		public function testInstantiated():void {
			assertTrue("mesa is Mesa", mesa is Mesa);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}