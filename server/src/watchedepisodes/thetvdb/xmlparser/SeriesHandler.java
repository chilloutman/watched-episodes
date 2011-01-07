package watchedepisodes.thetvdb.xmlparser;

import java.util.ArrayList;

import org.xml.sax.SAXException;

import watchedepisodes.entities.Series;
import chilloutman.xmlparser.SAXHandler;
import chilloutman.xmlparser.XMLElement;

import com.google.appengine.api.datastore.Text;

public class SeriesHandler extends SAXHandler<Series> {
	
	private static final String rootName= "Series";
	
	@Override
	protected Series getNewResult() throws SAXException {
		return new Series();
	}
	
	@Override
	protected boolean isRelevantParentElement (String elementName) throws SAXException {
		return (elementName == rootName);
	}
	
	@Override
	protected boolean isRelevantChildElement (String parentName, String elementName) throws SAXException {
		if (parentName == rootName) {
			return (elementName == "id" ||
					elementName == "Actors" ||
					elementName == "Overview" ||
					elementName == "SeriesName" ||
					elementName == "banner" ||
					elementName == "IMDB_ID" ||
					elementName == "Language" ||
					elementName == "FirstAired");
		}
		return false;
	}
	
	@Override
	protected void willStartParentElement (String parentName) throws SAXException {
		
	}
	
	@Override
	protected void parseChildElement(XMLElement element) {
		if (element.getParentName() == rootName) {
			if (element.getName() == "SeriesName") {
				getResult().setName(element.getContent());	
			} else if (element.getName() == "id") {
				getResult().setId(element.getContent());
			} else if (element.getName() == "Actors") {
				String[] actors= element.getContent().split("\\|");
				ArrayList<String> actorsList= new ArrayList<String>();
				for (int i= 1; i < actors.length ; i++) {
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
	protected void finishedParentElement (String parentName) throws SAXException {
		try {
			getResult().setKey();
		} catch (Exception e) {
			throw new SAXException(e);
		}
	}
	
	@Override
	protected void parsingEnded () throws SAXException {
		
	}
}
