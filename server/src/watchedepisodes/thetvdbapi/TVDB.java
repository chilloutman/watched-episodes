package watchedepisodes.thetvdbapi;

import java.util.List;

import watchedepisodes.entities.Episode;
import watchedepisodes.entities.Series;
import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.thetvdbapi.xmlparser.handlers.EpisodesHandler;
import watchedepisodes.thetvdbapi.xmlparser.handlers.SearchResultsHandler;
import watchedepisodes.thetvdbapi.xmlparser.handlers.SeriesHandler;

public class TVDB extends AbstractTVDB {
	
	public TVDB (String apiKey) {
		super(apiKey);
	}

	public List<SeriesFragment> searchSeries (String searchString, String language) throws TVDBException {
		String URL = URLFactory.getSearchSeriesURL(searchString, language);
		Request<List<SeriesFragment>> request =  new Request<List<SeriesFragment>>(URL, new SearchResultsHandler());
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
	
	public Series getSeries (String id, String language) throws TVDBException {
		String URL = URLFactory.getGetSeriesURL(id, language);
		Request<Series> request = new Request<Series>(URL, new SeriesHandler());
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
	
	public List<Episode> getAllEpisodes (String seriesId, String language) throws TVDBException {
		String URL = URLFactory.getGetAllEpisodesURL(seriesId, language);
		Request<List<Episode>> request = new Request<List<Episode>>(URL, new EpisodesHandler());
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
}
