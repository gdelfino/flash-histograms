package info.esdata {

	import asunit.framework.TestCase;

	public class BinColumnTest extends TestCase {
		private var binColumn:BinColumn;

		public function BinColumnTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			binColumn = new BinColumn();
		}

		override protected function tearDown():void {
			super.tearDown();
			binColumn = null;
		}

		public function testInstantiated():void {
			assertTrue("binColumn is BinColumn", binColumn is BinColumn);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}