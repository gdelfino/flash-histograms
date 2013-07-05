package info.esdata {

	import asunit.framework.TestCase;

	public class MunicipioTest extends TestCase {
		private var municipio:Municipio;

		public function MunicipioTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			municipio = new Municipio();
		}

		override protected function tearDown():void {
			super.tearDown();
			municipio = null;
		}

		public function testInstantiated():void {
			assertTrue("municipio is Municipio", municipio is Municipio);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}