package ch.neiva.watchedepisodes.thetvdbapi.xmlparser.handlers;

import java.util.ArrayList;
import java.util.List;

import org.xml.sax.SAXException;


import ch.neiva.watchedepisodes.entities.SeriesFragment;
import ch.neiva.xmlparser.SAXHandler;
import ch.neiva.xmlparser.XMLElement;

public class SearchResultsHandler extends SAXHandler<List<SeriesFragment>> {
	
	private static final String rootName= "Series";
	private ArrayList<SeriesFragment> searchResults = new ArrayList<SeriesFragment>();
	private SeriesFragment currentSeries;
	
	@Override
	public ArrayList<SeriesFragment> getResult () {
		return searchResults;
	}

	@Override
	protected void willStartElement (String elementName) {
		if (elementName == rootName) {
			currentSeries = new SeriesFragment();
			searchResults.add(currentSeries);
		}
	}
	
	@Override
	protected void parseElement (XMLElement element) throws SAXException {		
		if (element.getParentName() == rootName) {
			if (element.getName() == "SeriesName") {
				currentSeries.setName(element.getContent());	
			} else if (element.getName() == "id") {
				currentSeries.setId(element.getContent());
			}
		}
	}
	
	@Override
	protected void finishedElement (String parentName) throws SAXException {
		
	}
	
	@Override
	protected void parsingEnded () throws SAXException {
		
	}
}
