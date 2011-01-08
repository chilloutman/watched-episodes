package watchedepisodes.thetvdb;

import java.util.List;

import watchedepisodes.entities.Episode;
import watchedepisodes.entities.Series;
import watchedepisodes.entities.SeriesFragment;

public class TVDB {
	
	// TODO: Use the api to get mirrors
	private static final String BaseURL= "http://www.thetvdb.com/api/";
	private RequestAgent agent= new RequestAgent();
	private String apiKey;
	
	
	public TVDB (String apiKey) {
		this.apiKey= apiKey;
	}
	
	public List<SeriesFragment> searchSeries (String searchString, String language) throws TVDBException {
		SearchSeriesRequest request= new SearchSeriesRequest(BaseURL, searchString, language);
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
	
	public Series getSeries (String id, String language) throws TVDBException {
		GetSeriesRequest request= new GetSeriesRequest(BaseURL, apiKey, id, language);
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
	
	public List<Episode> getAllEpisodes (String seriesId, String language) throws TVDBException {
		GetAllEpisodesRequest request= new GetAllEpisodesRequest(BaseURL, apiKey, seriesId, language);
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
}
