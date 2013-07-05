package info.esdata {

	import asunit.framework.TestCase;

	public class DataLoaderTest extends TestCase {
		private var dataLoader:DataLoader;

		public function DataLoaderTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			dataLoader = new DataLoader();
		}

		override protected function tearDown():void {
			super.tearDown();
			dataLoader = null;
		}

		public function testInstantiated():void {
			assertTrue("dataLoader is DataLoader", dataLoader is DataLoader);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}