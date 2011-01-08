package watchedepisodes.thetvdb.xmlparser;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.xml.sax.SAXException;

import watchedepisodes.entities.Episode;
import chilloutman.xmlparser.SAXHandler;
import chilloutman.xmlparser.XMLElement;

import com.google.appengine.api.datastore.Text;

public class EpisodesHandler extends SAXHandler<List<Episode>> {
	
	private Episode currentEpisode;
	
	@Override
	protected ArrayList<Episode> getNewResult () throws SAXException {
		return new ArrayList<Episode>();
	}

	@Override
	protected boolean isRelevantParentElement (String elementName) throws SAXException {
		return (elementName == "Episode");
	}

	@Override
	protected void willStartParentElement (String parentName) throws SAXException {
		currentEpisode= new Episode();
	}
	
	@Override
	protected boolean isRelevantChildElement (String parentName, String elementName) throws SAXException {
		if (parentName == "Episode") {
			return (elementName == "id" ||
					elementName == "Language" ||
					elementName == "EpisodeName" ||
					elementName == "SeasonNumber" ||
					elementName == "EpisodeNumber" ||
					elementName == "Overview" ||
					elementName == "FirstAired" ||
					elementName == "Rating" ||
					elementName == "Writer" ||
					elementName == "Director" ||
					elementName == "GuestStars");
		}
		return false;
	}
	
	@Override
	protected void parseChildElement (XMLElement element) throws SAXException {
		if (element.getParentName() == "Episode" && currentEpisode != null) {
			if (element.getName() == "id") {
				currentEpisode.setId(element.getContent());
			} else if (element.getName() == "Language") {
				currentEpisode.setLanguage(element.getContent());
			} else if (element.getName() == "EpisodeName") {
				currentEpisode.setEpisodeName(element.getContent());
			} else if (element.getName() == "SeasonNumber") {				
				int seasonNumber= Integer.parseInt(element.getContent());
				if (seasonNumber == 0) {
					currentEpisode= null;
				} else {
					currentEpisode.setSeasonNumber(seasonNumber);
				}
			} else if (element.getName() == "EpisodeNumber") {
				currentEpisode.setEpisodeNumber(Integer.parseInt(element.getContent()));
			} else if (element.getName() == "Overview") {
				currentEpisode.setOverview(new Text(element.getContent()));
			} else if (element.getName() == "FirstAired") {
				currentEpisode.setFirstAired(element.getContent());
			} else if (element.getName() == "Rating") {
				currentEpisode.setRating(element.getContent());
			} else if (element.getName() == "Writer") {
				currentEpisode.setWriter(element.getContent());
			} else if (element.getName() == "Director") {
				currentEpisode.setDirector(element.getContent());
			} else if (element.getName() == "GuestStars") {
				String[] actors= element.getContent().split("\\|");
				currentEpisode.setGuestStars(Arrays.asList(actors));
			}
		}
	}

	@Override
	protected void finishedParentElement (String parentName) throws SAXException {
		if (currentEpisode != null) {
			try {
				currentEpisode.generateKey();
				getResult().add(currentEpisode);
			} catch (Exception e) {
				throw new SAXException(e);
			}
		}
	}

	@Override
	protected void parsingEnded () throws SAXException {
		// TODO Auto-generated method stub

	}

}
