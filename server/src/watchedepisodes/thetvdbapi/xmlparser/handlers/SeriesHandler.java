package watchedepisodes.thetvdbapi.xmlparser.handlers;

import java.util.ArrayList;

import org.xml.sax.SAXException;

import watchedepisodes.entities.Series;
import chilloutman.xmlparser.SAXHandler;
import chilloutman.xmlparser.XMLElement;

import com.google.appengine.api.datastore.Text;

public class SeriesHandler extends SAXHandler<Series> {

	private static final String rootName= "Series";
	private Series series = new Series();

	@Override
	public Series getResult () {
		return series;
	}

	@Override
	protected void willStartElement (String parentName) throws SAXException {

	}

	@Override
	protected void parseElement (XMLElement element) {
		if (element.getParentName() == rootName) {
			if (element.getName() == "SeriesName") {
				series.setName(element.getContent());
			} else if (element.getName() == "id") {
				series.setId(element.getContent());
			} else if (element.getName() == "Actors") {
				String[] actors= element.getContent().split("\\|");
				ArrayList<String> actorsList= new ArrayList<String>();
				for (int i= 1; i < actors.length; i++) {
					actorsList.add(actors[i]);
				}
				series.setActors(actorsList);
			} else if (element.getName() == "Overview") {
				Text overview= new Text(element.getContent());
				series.setOverview(overview);
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
		if (parentName == rootName) {
			try {
				series.generateKey();
			} catch (Exception e) {
				throw new SAXException(e);
			}
		}
	}

	@Override
	protected void parsingEnded () throws SAXException {

	}
}
