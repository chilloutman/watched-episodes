package watchedepisodes.thetvdbapi.xmlparser.protobuf;

import org.xml.sax.SAXException;

import watchedepisodes.servlets.protocols.ProtocolTypes.PBSeriesSummary;
import watchedepisodes.servlets.protocols.SearchSeriesProtocol.SearchSeriesResponse;
import chilloutman.xmlparser.SAXHandler;
import chilloutman.xmlparser.XMLElement;

import com.google.protobuf.GeneratedMessage;

public class SearchHandler extends SAXHandler<GeneratedMessage> {
	
	private static final String rootName = "Series";
	private SearchSeriesResponse.Builder responseBuilder = SearchSeriesResponse.newBuilder();
	private PBSeriesSummary.Builder currentSeries;
	private SearchSeriesResponse result;
	
	@Override
	public GeneratedMessage getResult () {
		return result;
	}

	@Override
	protected void willStartElement (String elementName) {
		if (elementName == rootName) {
			currentSeries = PBSeriesSummary.newBuilder();
		}
	}
	
	@Override
	protected void parseElement (XMLElement element) throws SAXException {		
		if (element.getParentName() == rootName) {
			if (element.getName() == "SeriesName") {
				currentSeries.setSeriesName(element.getContent());	
			} else if (element.getName() == "id") {
				currentSeries.setSeriesId(element.getContent());
			}
		}
	}
	
	@Override
	protected void finishedElement (String parentName) throws SAXException {
		if (parentName == rootName) {
			responseBuilder.addSeries(currentSeries);
		}
	}
	
	@Override
	protected void parsingEnded () throws SAXException {
		result = responseBuilder.build();
	}
}
