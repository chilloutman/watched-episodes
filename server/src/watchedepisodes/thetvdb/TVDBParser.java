package watchedepisodes.thetvdb;

import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

@SuppressWarnings("serial")
class ParseException extends Exception { }

public class TVDBParser {
	
	private SAXParser parser;
	
	void parse (InputStream xml, DefaultHandler handler) throws ParseException {
		try {
			getParser().parse(xml, handler);
		} catch (SAXException e) {
			e.printStackTrace();
			throw new ParseException();
		} catch (IOException e) {
			e.printStackTrace();
			throw new ParseException();
		} finally {
			try {
				xml.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	private SAXParser getParser () throws ParseException {
		if (parser == null) {
			SAXParserFactory factory = SAXParserFactory.newInstance();
			try {
				parser= factory.newSAXParser();
			} catch (ParserConfigurationException e) {
				e.printStackTrace();
				throw new ParseException();
			} catch (SAXException e) {
				e.printStackTrace();
				throw new ParseException();
			}
		} else {
			parser.reset();
		}
		return parser;
	}
}
