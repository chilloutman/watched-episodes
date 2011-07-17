package watchedepisodes.thetvdbapi;

import watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse;
import watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode;
import watchedepisodes.servlets.protocols.ProtocolTypes.PBSeries;
import watchedepisodes.servlets.protocols.ProtocolTypes.PBSeriesSummary;
import watchedepisodes.servlets.protocols.SearchSeriesProtocol.SearchSeriesResponse;

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
		return seriesBuilder.build();
	}

	@Override
	public GeneratedMessage getAllEpisodes(String seriesId, String language) throws TVDBException {
		GetAllEpisodesResponse.Builder response = GetAllEpisodesResponse.newBuilder();
		for (int seasonNumber = 0; seasonNumber < 2; seasonNumber++) {
			for (int episodeNumber = 0; episodeNumber < 2; episodeNumber++) {
				PBEpisode.Builder episodeBuilder = PBEpisode.newBuilder();
				episodeBuilder.setSeriesId(String.valueOf(seasonNumber) + "x" + String.valueOf(episodeNumber));
				episodeBuilder.setEpisodeName("Episode " + String.valueOf(seasonNumber) + "x" + String.valueOf(episodeNumber));
				episodeBuilder.setEpisodeNumber(episodeNumber);
				episodeBuilder.setSeasonNumber(seasonNumber);
				response.addEpisodes(episodeBuilder);
			}
		}
		
		return response.build();
	}

}
