package watchedepisodes.thetvdb;

import java.util.ArrayList;
import java.util.List;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import watchedepisodes.entities.SeriesFragment;

public class SearchResultsHandler extends DefaultHandler {
	
	private ArrayList<SeriesFragment> result;
	private SeriesFragment currentSeries;
	private String currentElement;
	private StringBuilder currentValue;
	
	List<SeriesFragment> getResult () {
		return result;
	}
	
	public SearchResultsHandler() {
		result= new ArrayList<SeriesFragment>();
	}
	
	@Override
	public void startDocument () throws SAXException {
		currentElement= "";
		currentValue= new StringBuilder();
	}
	
	@Override
	public void startElement (String uri, String localName, String qName, Attributes atts) throws SAXException {
		if (qName == "Series") {
			currentSeries= new SeriesFragment();
		} else {
			currentElement= (elementIsRelevant(qName)) ? qName : "";
		}
	}
	
	@Override
	public void characters (char[] ch, int start, int length) throws SAXException {
		if (elementIsRelevant(currentElement)) {
			String content= new String(ch).substring(start, start + length);
			currentValue.append(content);
		}
	}
	
	private boolean elementIsRelevant (String elementName) {
		return (elementName == "SeriesName" ||
				elementName == "id");
	}
	
	@Override
	public void endElement (String uri, String localName, String qName) throws SAXException {
		if (qName == "Series") {
			result.add(currentSeries);
			return;
		}
		
		if (qName == "SeriesName") {
			currentSeries.setName(currentValue.toString());	
		} else if (qName == "id") {
			currentSeries.setId(currentValue.toString());
		}
		
		currentValue.delete(0, currentValue.length());
	}

	@Override
	public void endDocument () throws SAXException {
	}
}
