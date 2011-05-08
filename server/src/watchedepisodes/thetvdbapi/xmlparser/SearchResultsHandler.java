package watchedepisodes.thetvdbapi.xmlparser;

import java.util.ArrayList;
import java.util.List;

import org.xml.sax.SAXException;

import watchedepisodes.entities.SeriesFragment;

import chilloutman.xmlparser.SAXHandler;
import chilloutman.xmlparser.XMLElement;

public class SearchResultsHandler extends SAXHandler<List<SeriesFragment>> {
	
	private static final String rootName= "Series";
	private SeriesFragment currentSeries;
	
	@Override
	protected ArrayList<SeriesFragment> getNewResult () throws SAXException {
		return new ArrayList<SeriesFragment>();
	}

	@Override
	protected void willStartElement (String elementName) {
		if (elementName == rootName) {
			currentSeries= new SeriesFragment();
			getResult().add(currentSeries);
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
