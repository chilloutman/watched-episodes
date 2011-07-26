package watchedepisodes.thetvdbapi.xmlparser.handlers;

import org.xml.sax.SAXException;

import watchedepisodes.thetvdbapi.TVDBUpdates;
import chilloutman.xmlparser.SAXHandler;
import chilloutman.xmlparser.XMLElement;

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
			} else if (element.getParentName().equals("Time")) {
				updates.setUnixTime(Long.parseLong(element.getContent()));
			}
		}
	}

	@Override
	protected void finishedElement (String elementName) throws SAXException { }

	@Override
	protected void parsingEnded () throws SAXException { }
	
}
