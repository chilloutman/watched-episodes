package watchedepisodes.thetvdbapi;

import java.util.List;

import watchedepisodes.entities.Episode;
import watchedepisodes.entities.Series;
import watchedepisodes.entities.SeriesFragment;

public class TVDB {
	
	// TODO: Use the api to get mirrors
	private static final String BaseURL= "http://www.thetvdb.com/api/";
	private RequestFactory requestFactory; 
	private RequestAgent agent;
	
	
	public TVDB (String apiKey) {
		this.requestFactory = new RequestFactory(BaseURL, apiKey);
		this.agent = new RequestAgent();
	}
	
	public List<SeriesFragment> searchSeries (String searchString, String language) throws TVDBException {
		Request<List<SeriesFragment>> request = requestFactory.getSearchSeriesRequest(searchString, language);
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
	
	public Series getSeries (String id, String language) throws TVDBException {
		Request<Series> request = requestFactory.getGetSeriesRequest(id, language);
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
	
	public List<Episode> getAllEpisodes (String seriesId, String language) throws TVDBException {
		Request<List<Episode>> request = requestFactory.getGetAllEpisodesRequest(seriesId, language);
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
}
