package info.esdata {

	import asunit.framework.TestCase;

	public class EtiquetaDinamicaTest extends TestCase {
		private var instance:EtiquetaDinamica;

		public function EtiquetaDinamicaTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new EtiquetaDinamica();
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is EtiquetaDinamica", instance is EtiquetaDinamica);
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
	}
}