package watchedepisodes.thetvdb;

import java.util.ArrayList;
import java.util.Arrays;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import watchedepisodes.entities.Series;

import com.google.appengine.api.datastore.Text;

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
			currentElement= (isElementRelevant(qName)) ? qName : null;
		}
	}
	
	@Override
	public void characters (char[] ch, int start, int length) throws SAXException {
		if (currentElement != null) {
			String content= new String(ch).substring(start, start + length);
			currentValue.append(content);
		}
	}
	
	private boolean isElementRelevant (String elementName) {
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
		if (currentElement == null) {
			return;
		}
		
		String content= currentValue.toString(); 
		
		if (qName == "SeriesName") {
			result.setName(content);	
		} else if (qName == "id") {
			result.setId(content);
		} else if (qName == "Actors") {
			String[] actors= content.split("\\|");
			ArrayList<String> actorsList= new ArrayList<String>();
			for (int i= 1; i < actors.length ; i++) {
				actorsList.add(actors[i]);
			}
			result.setActors(actorsList);
		} else if (qName == "Overview") {
			Text overview= new Text(content);
			result.setOverview(overview);
		} else if (qName == "banner") {
			result.setBanner(content);
		} else if (qName == "IMDB_ID") {
			result.setImdbId(content);
		} else if (qName == "FirstAired") {
			result.setFirstAired(content);
		}
		
		currentValue.delete(0, currentValue.length());
	}

	@Override
	public void endDocument () throws SAXException {
	}
}
