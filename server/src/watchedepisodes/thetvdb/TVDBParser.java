package watchedepisodes.thetvdb;

import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class TVDBParser {
	
	private SAXParser parser;
	
	void parse (InputStream xml, DefaultHandler handler) {
		try {
			getParser().parse(xml, handler);
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				xml.close();
			} catch (IOException e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
		}
	}
	
	private SAXParser getParser () {
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
