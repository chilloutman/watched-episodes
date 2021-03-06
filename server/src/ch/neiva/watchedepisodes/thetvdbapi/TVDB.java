package ch.neiva.watchedepisodes.thetvdbapi;

import java.util.List;

import ch.neiva.watchedepisodes.entities.Episode;
import ch.neiva.watchedepisodes.entities.Series;
import ch.neiva.watchedepisodes.entities.SeriesFragment;
import ch.neiva.watchedepisodes.thetvdbapi.xmlparser.handlers.EpisodesHandler;
import ch.neiva.watchedepisodes.thetvdbapi.xmlparser.handlers.SearchResultsHandler;
import ch.neiva.watchedepisodes.thetvdbapi.xmlparser.handlers.SeriesHandler;


public class TVDB extends AbstractTVDB<List<SeriesFragment>, Series, List<Episode>>  {
	
	public TVDB (String apiKey) {
		super(apiKey);
	}
	
	@Override
	public List<SeriesFragment> searchSeries (String searchString, String language) throws TVDBException {
		String URL = URLFactory.getSearchSeriesURL(searchString, language);
		Request<List<SeriesFragment>> request =  new Request<List<SeriesFragment>>(URL, new SearchResultsHandler());
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
	
	@Override
	public Series getSeries (String id, String language) throws TVDBException {
		String URL = URLFactory.getGetSeriesURL(id, language);
		Request<Series> request = new Request<Series>(URL, new SeriesHandler());
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
	
	@Override
	public List<Episode> getAllEpisodes (String seriesId, String language) throws TVDBException {
		String URL = URLFactory.getGetAllEpisodesURL(seriesId, language);
		Request<List<Episode>> request = new Request<List<Episode>>(URL, new EpisodesHandler());
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
}
