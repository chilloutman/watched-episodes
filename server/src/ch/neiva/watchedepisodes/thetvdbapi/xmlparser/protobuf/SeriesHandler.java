package ch.neiva.watchedepisodes.thetvdbapi.xmlparser.protobuf;

import java.util.ArrayList;

import org.xml.sax.SAXException;

import ch.neiva.watchedepisodes.servlets.protocols.GetSeriesProtocol.GetSeriesResponse;
import ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBSeries;
import ch.neiva.xmlparser.SAXHandler;
import ch.neiva.xmlparser.XMLElement;

import com.google.protobuf.GeneratedMessage;

public class SeriesHandler extends SAXHandler<GeneratedMessage> {
	private static final String rootName= "Series";
	private PBSeries.Builder series = PBSeries.newBuilder();

	@Override
	public GeneratedMessage getResult () {
		GetSeriesResponse.Builder response = GetSeriesResponse.newBuilder();
		response.setSeries(series);
		return response.build();
	}

	@Override
	protected void willStartElement (String parentName) throws SAXException {

	}

	@Override
	protected void parseElement (XMLElement element) {
		if (element.getParentName() == rootName) {
			if (element.getName() == "SeriesName") {
				series.setSeriesName(element.getContent());
			} else if (element.getName() == "id") {
				series.setSeriesId(element.getContent());
			} else if (element.getName() == "Actors") {
				String[] actors = element.getContent().split("\\|");
				ArrayList<String> actorsList= new ArrayList<String>();
				for (int i= 1; i < actors.length; i++) {
					actorsList.add(actors[i]);
				}
				series.addAllActors(actorsList);
			} else if (element.getName() == "Overview") {
				series.setOverview(element.getContent());
			} else if (element.getName() == "banner") {
				series.setBanner(element.getContent());
			} else if (element.getName() == "IMDB_ID") {
				series.setImdbId(element.getContent());
			} else if (element.getName() == "Language") {
				series.setLanguage(element.getContent());
			} else if (element.getName() == "FirstAired") {
				series.setFirstAired(element.getContent());
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
