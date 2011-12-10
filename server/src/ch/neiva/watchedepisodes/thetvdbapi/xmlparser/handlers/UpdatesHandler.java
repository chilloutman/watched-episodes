package ch.neiva.watchedepisodes.thetvdbapi.xmlparser.handlers;

import org.xml.sax.SAXException;

import ch.neiva.watchedepisodes.thetvdbapi.TVDBUpdates;
import ch.neiva.xmlparser.SAXHandler;
import ch.neiva.xmlparser.XMLElement;

public class UpdatesHandler extends SAXHandler<TVDBUpdates> {
	
	private final String rootElement = "Items";
	private TVDBUpdates updates;
	
	@Override
	public TVDBUpdates getResult () {
		return updates;
	}

	@Override
	protected void willStartElement (String elementName) throws SAXException {
		if (elementName.equals(rootElement)) {
			updates = new TVDBUpdates();
		}
	}

	@Override
	protected void parseElement (XMLElement element) throws SAXException {
		if (element.getParentName().equals(rootElement)) {
			if (element.getName().equals("Series")) {
				updates.addSeriesId(element.getContent());
			} else if (element.getName().equals("Time")) {
				updates.setUnixTime(Long.parseLong(element.getContent()));
			}
		}
	}

	@Override
	protected void finishedElement (String elementName) throws SAXException { }

	@Override
	protected void parsingEnded () throws SAXException { }
	
}
