package ch.neiva.watchedepisodes.thetvdbapi;


import ch.neiva.watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse;
import ch.neiva.watchedepisodes.servlets.protocols.GetSeriesProtocol.GetSeriesResponse;
import ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode;
import ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBSeries;
import ch.neiva.watchedepisodes.servlets.protocols.ProtocolTypes.PBSeriesSummary;
import ch.neiva.watchedepisodes.servlets.protocols.SearchSeriesProtocol.SearchSeriesResponse;

import com.google.protobuf.GeneratedMessage;

public class OfflineTVDB extends ProtobufTVDB {

	public OfflineTVDB(String apiKey) {
		super(apiKey);
	}

	@Override
	public GeneratedMessage searchSeries(String searchString, String language) throws TVDBException {
		SearchSeriesResponse.Builder searchResults = SearchSeriesResponse.newBuilder();
		for (int i = 0; i < 3; i++) {
			PBSeriesSummary.Builder seriesSummary = PBSeriesSummary.newBuilder();
			seriesSummary.setSeriesId(String.valueOf(i));
			seriesSummary.setSeriesName("SeriesName " + String.valueOf(i));
			searchResults.addSeries(seriesSummary);
		}
		
		return searchResults.build();
	}

	@Override
	public GeneratedMessage getSeries(String id, String language) throws TVDBException {
		PBSeries.Builder seriesBuilder = PBSeries.newBuilder();
		seriesBuilder.setSeriesId(id);
		seriesBuilder.setSeriesName("SeriesName " + id);
		seriesBuilder.setOverview("This text is the overview text of the series.");
		seriesBuilder.setLanguage(language);
		seriesBuilder.setFirstAired("The beginning of time");
		seriesBuilder.setBanner("");
		seriesBuilder.setImdbId("0");
		
		GetSeriesResponse.Builder message = GetSeriesResponse.newBuilder();
		message.setSeries(seriesBuilder);
		return message.build();
	}

	@Override
	public GeneratedMessage getAllEpisodes(String seriesId, String language) throws TVDBException {
		GetAllEpisodesResponse.Builder response = GetAllEpisodesResponse.newBuilder();
		for (int seasonNumber = 1; seasonNumber < 4; seasonNumber++) {
			for (int episodeNumber = 1; episodeNumber < 11; episodeNumber++) {
				PBEpisode.Builder episodeBuilder = PBEpisode.newBuilder();
				episodeBuilder.setSeriesId(seriesId);
				episodeBuilder.setEpisodeName("Episode " + String.valueOf(seasonNumber) + "x" + String.valueOf(episodeNumber));
				episodeBuilder.setEpisodeNumber(episodeNumber);
				episodeBuilder.setSeasonNumber(seasonNumber);
				episodeBuilder.setEpisodeId(seriesId + "-" + String.valueOf(seasonNumber) + "x" + String.valueOf(episodeNumber));
				episodeBuilder.setLanguage(language);
				episodeBuilder.setOverview("This is the overview text for this episode.");
				episodeBuilder.setRating("8");
				episodeBuilder.setWriter("Ms. Writer");
				episodeBuilder.setDirector("Mr. Director");
				episodeBuilder.setFirstAired("01.01.1970");
				response.addEpisodes(episodeBuilder);
			}
		}
		
		return response.build();
	}

}
