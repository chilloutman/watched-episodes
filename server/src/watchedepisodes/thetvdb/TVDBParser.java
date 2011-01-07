package watchedepisodes.thetvdb;

import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

@SuppressWarnings("serial")
class TVDBParseException extends Exception { }

public class TVDBParser {
	
	private SAXParser parser;
	
	void parse (InputStream xml, DefaultHandler handler) throws TVDBParseException {
		try {
			getParser().parse(xml, handler);
		} catch (SAXException e) {
			e.printStackTrace();
			throw new TVDBParseException();
		} catch (IOException e) {
			e.printStackTrace();
			throw new TVDBParseException();
		} finally {
			try {
				xml.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	private SAXParser getParser () throws TVDBParseException {
		if (parser == null) {
			SAXParserFactory factory = SAXParserFactory.newInstance();
			try {
				parser= factory.newSAXParser();
			} catch (ParserConfigurationException e) {
				e.printStackTrace();
			} catch (SAXException e) {
				e.printStackTrace();
			}
		} else {
			parser.reset();
		}
		return parser;
	}
}
