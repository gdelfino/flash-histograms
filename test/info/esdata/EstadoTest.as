package info.esdata {

	import asunit.framework.TestCase;

	public class EstadoTest extends TestCase {
		private var estado:Estado;

		public function EstadoTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			estado = new Estado();
		}

		override protected function tearDown():void {
			super.tearDown();
			estado = null;
		}

		public function testInstantiated():void {
			assertTrue("estado is Estado", estado is Estado);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}