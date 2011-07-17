package watchedepisodes.thetvdbapi.xmlparser;

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
			System.err.println(e.getMessage());
			throw new ParseException();
		} catch (IOException e) {
			System.err.println(e.getMessage());
			throw new ParseException();
		}
	}
	
	private SAXParser getParser () throws ParseException {
		if (parser == null) {
			SAXParserFactory factory = SAXParserFactory.newInstance();
			try {
				parser = factory.newSAXParser();
			} catch (ParserConfigurationException e) {
				System.err.println(e.getMessage());
				throw new ParseException();
			} catch (SAXException e) {
				System.err.println(e.getMessage()); 
				throw new ParseException();
			}
		} else {
			parser.reset();
		}
		
		return parser;
	}
}
