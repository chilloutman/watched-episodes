package watchedepisodes.thetvdb;

import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

public class DefaultErrorHandler implements ErrorHandler {

	@Override
	public void error(SAXParseException exception) throws SAXException {
		exception.printStackTrace();
	}

	@Override
	public void fatalError(SAXParseException exception) throws SAXException {
		exception.printStackTrace();
	}

	@Override
	public void warning(SAXParseException exception) throws SAXException {
		exception.printStackTrace();
	}

}
