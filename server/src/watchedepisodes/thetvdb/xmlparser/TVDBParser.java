package watchedepisodes.thetvdb.xmlparser;

import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class TVDBParser {
	
	private SAXParser parser;
	
	public void parse (InputStream xml, DefaultHandler handler) throws ParseException {
		try {
			getParser().parse(xml, handler);
		} catch (SAXException e) {
			e.printStackTrace();
			throw new ParseException();
		} catch (IOException e) {
			e.printStackTrace();
			throw new ParseException();
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
