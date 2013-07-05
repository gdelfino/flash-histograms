package info.esdata {

	import asunit.framework.TestCase;

	public class ParroquiaTest extends TestCase {
		private var parroquia:Parroquia;

		public function ParroquiaTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			parroquia = new Parroquia();
		}

		override protected function tearDown():void {
			super.tearDown();
			parroquia = null;
		}

		public function testInstantiated():void {
			assertTrue("parroquia is Parroquia", parroquia is Parroquia);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}