package watchedepisodes.thetvdb;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import watchedepisodes.entities.Series;
import watchedepisodes.entities.SeriesFragment;

public class SeriesHandler extends DefaultHandler {
	private Series result;
	private String currentElement;
	private StringBuilder currentValue;
	
	Series getResult () {
		return result;
	}
	
	@Override
	public void startDocument () throws SAXException {
		currentElement= null;
		currentValue= new StringBuilder();
	}
	
	@Override
	public void startElement (String uri, String localName, String qName, Attributes atts) throws SAXException {
		if (qName == "Series") {
			result= new Series();
		} else {
			currentElement= (elementIsRelevant(qName)) ? qName : null;
		}
	}
	
	@Override
	public void characters (char[] ch, int start, int length) throws SAXException {
		if (currentElement != null) {
			String content= new String(ch).substring(start, start + length);
			currentValue.append(content);
		}
	}
	
	private boolean elementIsRelevant (String elementName) {
		return (elementName == "id" ||
				elementName == "Actors" ||
				elementName == "Overview" ||
				elementName == "SeriesName" ||
				elementName == "banner" ||
				elementName == "IMDB_ID" ||
				elementName == "FirstAired");
	}
	
	@Override
	public void endElement (String uri, String localName, String qName) throws SAXException {
		if (qName == "Series") {
			return;
		}
		
		if (qName == "SeriesName") {
			result.setName(currentValue.toString());	
		} else if (qName == "id") {
			result.setId(currentValue.toString());
		}
		
		currentValue.delete(0, currentValue.length());
	}

	@Override
	public void endDocument () throws SAXException {
	}
}
