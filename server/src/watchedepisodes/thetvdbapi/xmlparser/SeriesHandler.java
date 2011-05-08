package watchedepisodes.thetvdbapi.xmlparser;

import java.util.ArrayList;

import org.xml.sax.SAXException;

import watchedepisodes.entities.Series;
import chilloutman.xmlparser.SAXHandler;
import chilloutman.xmlparser.XMLElement;

import com.google.appengine.api.datastore.Text;

public class SeriesHandler extends SAXHandler<Series> {

	private static final String rootName= "Series";

	@Override
	protected Series getNewResult () throws SAXException {
		return new Series();
	}

	@Override
	protected void willStartElement (String parentName) throws SAXException {

	}

	@Override
	protected void parseElement (XMLElement element) {
		if (element.getParentName() == rootName) {
			if (element.getName() == "SeriesName") {
				getResult().setName(element.getContent());
			} else if (element.getName() == "id") {
				getResult().setId(element.getContent());
			} else if (element.getName() == "Actors") {
				String[] actors= element.getContent().split("\\|");
				ArrayList<String> actorsList= new ArrayList<String>();
				for (int i= 1; i < actors.length; i++) {
					actorsList.add(actors[i]);
				}
				getResult().setActors(actorsList);
			} else if (element.getName() == "Overview") {
				Text overview= new Text(element.getContent());
				getResult().setOverview(overview);
			} else if (element.getName() == "banner") {
				getResult().setBanner(element.getContent());
			} else if (element.getName() == "IMDB_ID") {
				getResult().setImdbId(element.getContent());
			} else if (element.getName() == "Language") {
				getResult().setLanguage(element.getContent());
			} else if (element.getName() == "FirstAired") {
				getResult().setFirstAired(element.getContent());
			}
		}
	}

	@Override
	protected void finishedElement (String parentName) throws SAXException {
		if (parentName == rootName) {
			try {
				getResult().generateKey();
			} catch (Exception e) {
				throw new SAXException(e);
			}
		}
	}

	@Override
	protected void parsingEnded () throws SAXException {

	}
}
