package watchedepisodes.servlets.protocols;

import java.util.List;

import watchedepisodes.entities.Episode;
import watchedepisodes.entities.Series;
import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.servlets.protocols.GetAllEpisodesProtocol.GetAllEpisodesResponse;
import watchedepisodes.servlets.protocols.GetSeriesProtocol.GetSeriesResponse;
import watchedepisodes.servlets.protocols.ProtocolTypes.PBEpisode;
import watchedepisodes.servlets.protocols.ProtocolTypes.PBSeries;
import watchedepisodes.servlets.protocols.ProtocolTypes.PBSeriesSummary;
import watchedepisodes.servlets.protocols.SearchSeriesProtocol.SearchSeriesResponse;

import com.google.protobuf.GeneratedMessage;

public abstract class ProtocolFactory {
	
	public static GeneratedMessage buildGetSeriesResponse (Series s) {
		PBSeries.Builder series = PBSeries.newBuilder();
		series.setSeriesId(s.getId());
		series.setLanguage(s.getLanguage());
		series.setSeriesName(s.getName());
		series.setOverview(s.getOverview().getValue());
		series.setFirstAired(s.getFirstAired());
		series.addAllActors(s.getActors());
		series.setBanner(s.getBanner());
		series.setImdbId(s.getImdbId());
		
		GetSeriesResponse.Builder response = GetSeriesResponse.newBuilder();
		response.setSeries(series);
		
		return response.build();
	}
	
	public static GeneratedMessage buildSearchSeriesResponse (List<SeriesFragment> results) {
		SearchSeriesResponse.Builder searchResults = SearchSeriesResponse.newBuilder();
		
		for (SeriesFragment s : results) {
			PBSeriesSummary.Builder series = PBSeriesSummary.newBuilder();
			series.setSeriesId(s.getId());
			series.setSeriesName(s.getName());
			searchResults.addSeries(series);
		}
		
		return searchResults.build();
	}
	
	public static GeneratedMessage buildGetAllSeriesResponse (List<Episode> episodes) {
		GetAllEpisodesResponse.Builder episodesResponse = GetAllEpisodesResponse.newBuilder();
		
		for (Episode e : episodes) {
			PBEpisode.Builder episode = PBEpisode.newBuilder();
			episode.setDirector(e.getDirector());
			episode.setEpisodeId(e.getId());
			episode.setEpisodeName(e.getEpisodeName());
			episode.setEpisodeNumber(e.getEpisodeNumber());
			episode.setFirstAired(e.getFirstAired());
			episode.setLanguage(e.getLanguage());
			episode.setOverview(e.getOverview().getValue());
			episode.setRating(e.getRating());
			episode.setSeasonNumber(e.getSeasonNumber());
			// TODO: Set a real seriesId
			episode.setSeriesId("TODO");
			episode.setWriter(e.getWriter());
			episodesResponse.addEpisodes(episode);
		}
		
		return episodesResponse.build();
	}
}
