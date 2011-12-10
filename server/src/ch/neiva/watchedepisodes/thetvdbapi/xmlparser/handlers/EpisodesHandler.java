package ch.neiva.watchedepisodes.thetvdbapi.xmlparser.handlers;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.xml.sax.SAXException;

import ch.neiva.watchedepisodes.entities.Episode;
import ch.neiva.xmlparser.SAXHandler;
import ch.neiva.xmlparser.XMLElement;

import com.google.appengine.api.datastore.Text;

public class EpisodesHandler extends SAXHandler<List<Episode>> {
	
	private ArrayList<Episode> parsedEpisodes = new ArrayList<Episode>();
	private Episode currentEpisode;
	private final String rootElementName= "Episode";
	private boolean skipCurrentEpisode;

	@Override
	public List<Episode> getResult () {
		return parsedEpisodes;
	}

	protected void willStartElement (String elementName) throws SAXException {
		if (elementName == rootElementName) {
			currentEpisode = new Episode();
			skipCurrentEpisode = false;
		}
	}

	@Override
	protected void parseElement (XMLElement element) throws SAXException {
		if (skipCurrentEpisode) {
			return;
		}

		if (element.getParentName() == rootElementName) {
			if (element.getName() == "SeasonNumber") {
				int seasonNumber= Integer.parseInt(element.getContent());
				if (seasonNumber == 0) {
					skipCurrentEpisode= true;
				} else {
					currentEpisode.setSeasonNumber(seasonNumber);
				}
			} else if (element.getName() == "EpisodeNumber") {
				int episodeNumber = Integer.parseInt(element.getContent());
				if (episodeNumber == 0) {
					skipCurrentEpisode= true;
				} else {
					currentEpisode.setEpisodeNumber(episodeNumber);
				}
			} else if (element.getName() == "id") {
				currentEpisode.setId(element.getContent());
			} else if (element.getName() == "Language") {
				currentEpisode.setLanguage(element.getContent());
			} else if (element.getName() == "EpisodeName") {
				currentEpisode.setEpisodeName(element.getContent());
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
	protected void finishedElement (String elementName) throws SAXException {
		if (!skipCurrentEpisode && elementName == rootElementName) {
			try {
				currentEpisode.generateKey();
				parsedEpisodes.add(currentEpisode);
			} catch (Exception e) {
				throw new SAXException(e);
			}
		}
	}

	@Override
	protected void parsingEnded () throws SAXException {

	}

}
