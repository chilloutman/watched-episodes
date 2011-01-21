package watchedepisodes.servlets.protocols;

import java.util.List;

import watchedepisodes.entities.Series;
import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries;
import watchedepisodes.servlets.protocols.SearchSeriesProtocol.PBSearchResults;
import watchedepisodes.servlets.protocols.SearchSeriesProtocol.PBSearchResults.PBSeriesSummary;

import com.google.protobuf.GeneratedMessage;

public abstract class ProtocolFactory {
	
	public static GeneratedMessage buildGetSeriesProto (Series s) {
		PBSeries.Builder series= PBSeries.newBuilder();
		series.setId(s.getId());
		series.setLanguage(s.getLanguage());
		series.setName(s.getName());
		series.setOverview(s.getOverview().toString());
		series.setFirstAired(s.getFirstAired());
		series.addAllActors(s.getActors());
		series.setBanner(s.getBanner());
		series.setImdbId(s.getImdbId());
		
		return series.build();
	}
	
	public static GeneratedMessage buildSearchResultsProto (List<SeriesFragment> results) {
		PBSearchResults.Builder searchResults= PBSearchResults.newBuilder();
		
		for (SeriesFragment s : results) {
			PBSeriesSummary.Builder series= PBSeriesSummary.newBuilder();
			series.setId(s.getId());
			series.setName(s.getName());
			searchResults.addSeries(series);
		}
		
		return searchResults.build();
	}
}
