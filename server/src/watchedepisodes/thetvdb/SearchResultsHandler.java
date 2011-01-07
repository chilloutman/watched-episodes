package watchedepisodes.thetvdb;

import java.util.ArrayList;

import org.xml.sax.SAXException;

import watchedepisodes.entities.SeriesFragment;

import chilloutman.xmlparser.SAXHandler;
import chilloutman.xmlparser.XMLElement;

public class SearchResultsHandler extends SAXHandler<ArrayList<SeriesFragment>> {
	
	private static final String rootName= "Series";
	SeriesFragment currentSeries;
	
	@Override
	protected ArrayList<SeriesFragment> getNewResult () throws SAXException {
		return new ArrayList<SeriesFragment>();
	}
	
	@Override
	protected boolean isRelevantParentElement (String elementName) throws SAXException {
		return (elementName == rootName);
	}

	@Override
	protected boolean isRelevantChildElement (String parentName, String elementName) throws SAXException {
		if (parentName == rootName) {
			return (elementName == "SeriesName" ||
					elementName == "id");
		}
		return false;
	}

	@Override
	protected void willStartParentElement (String parentName) {
		currentSeries= new SeriesFragment();
		getResult().add(currentSeries);
	}
	
	@Override
	protected void parseChildElement (XMLElement element) throws SAXException {		
		if (element.getParentName() == rootName) {
			if (element.getName() == "SeriesName") {
				currentSeries.setName(element.getContent());	
			} else if (element.getName() == "id") {
				currentSeries.setId(element.getContent());
			}
		}
	}
	
	@Override
	protected void finishedParentElement (String parentName) throws SAXException {
		
	}
	
	@Override
	protected void parsingEnded () throws SAXException {
		
	}
}
