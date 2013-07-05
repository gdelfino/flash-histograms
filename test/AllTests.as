package {
	/**
	 * This file has been automatically created using
	 * #!/usr/bin/ruby script/generate suite
	 * If you modify it and run this script, your
	 * modifications will be lost!
	 */

	import asunit.framework.TestSuite;
	import info.esdata.AxesTest;
	import info.esdata.BinColumnTest;
	import info.esdata.CentroTest;
	import info.esdata.DataLoaderTest;
	import info.esdata.DoubleSwitchTest;
	import info.esdata.EnlacesTest;
	import info.esdata.EstadoTest;
	import info.esdata.EtiquetaDinamicaTest;
	import info.esdata.FullScreenButtonTest;
	import info.esdata.HistogramTest;
	import info.esdata.MesaTest;
	import info.esdata.MunicipioTest;
	import info.esdata.ParroquiaTest;

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(new info.esdata.AxesTest());
			addTest(new info.esdata.BinColumnTest());
			addTest(new info.esdata.CentroTest());
			addTest(new info.esdata.DataLoaderTest());
			addTest(new info.esdata.DoubleSwitchTest());
			addTest(new info.esdata.EnlacesTest());
			addTest(new info.esdata.EstadoTest());
			addTest(new info.esdata.EtiquetaDinamicaTest());
			addTest(new info.esdata.FullScreenButtonTest());
			addTest(new info.esdata.HistogramTest());
			addTest(new info.esdata.MesaTest());
			addTest(new info.esdata.MunicipioTest());
			addTest(new info.esdata.ParroquiaTest());
		}
	}
}
