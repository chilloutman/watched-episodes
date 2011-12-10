package ch.neiva.watchedepisodes.thetvdbapi.xmlparser.protobuf;

import java.util.Arrays;

import org.xml.sax.SAXException;

import ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse;
import ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode;
import ch.neiva.xmlparser.SAXHandler;
import ch.neiva.xmlparser.XMLElement;

import com.google.protobuf.GeneratedMessage;

public class EpisodesHandler extends SAXHandler<GeneratedMessage> {
	
	private String seriesId;
	private final String rootElementName = "Episode";
	private GetAllEpisodesResponse.Builder episodesResponse = GetAllEpisodesResponse.newBuilder();
	private PBEpisode.Builder currentEpisode;
	private boolean skipCurrentEpisode;
	
	public EpisodesHandler (String seriesId) {
		this.seriesId = seriesId;
	}
	
	@Override
	public GeneratedMessage getResult () {
		return episodesResponse.build();
	}

	protected void willStartElement (String elementName) throws SAXException {
		if (elementName == rootElementName) {
			currentEpisode = PBEpisode.newBuilder();
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
				int seasonNumber = Integer.parseInt(element.getContent());
				if (seasonNumber == 0) {
					skipCurrentEpisode = true;
				} else {
					currentEpisode.setSeasonNumber(seasonNumber);
				}
			} else if (element.getName() == "EpisodeNumber") {
				int episodeNumber = Integer.parseInt(element.getContent());
				if (episodeNumber == 0) {
					skipCurrentEpisode = true;
				} else {
					currentEpisode.setEpisodeNumber(episodeNumber);
				}
			} else if (element.getName() == "id") {
				currentEpisode.setEpisodeId(element.getContent());
			} else if (element.getName() == "Language") {
				currentEpisode.setLanguage(element.getContent());
			} else if (element.getName() == "EpisodeName") {
				currentEpisode.setEpisodeName(element.getContent());
			} else if (element.getName() == "Overview") {
				currentEpisode.setOverview(element.getContent());
			} else if (element.getName() == "FirstAired") {
				currentEpisode.setFirstAired(element.getContent());
			} else if (element.getName() == "Rating") {
				currentEpisode.setRating(element.getContent());
			} else if (element.getName() == "Writer") {
				currentEpisode.setWriter(element.getContent());
			} else if (element.getName() == "Director") {
				currentEpisode.setDirector(element.getContent());
			} else if (element.getName() == "GuestStars") {
				String[] actors = element.getContent().split("\\|");
				currentEpisode.addAllGuestStars(Arrays.asList(actors));
			}
		}
	}

	@Override
	protected void finishedElement (String elementName) throws SAXException {
		if (!skipCurrentEpisode && elementName == rootElementName) {
			currentEpisode.setSeriesId(seriesId);
			episodesResponse.addEpisodes(currentEpisode);
		}
	}

	@Override
	protected void parsingEnded () throws SAXException {

	}
}
