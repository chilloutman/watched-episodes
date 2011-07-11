package watchedepisodes.thetvdbapi;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import watchedepisodes.entities.Episode;
import watchedepisodes.entities.Series;
import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.thetvdbapi.xmlparser.handlers.EpisodesHandler;
import watchedepisodes.thetvdbapi.xmlparser.handlers.SearchResultsHandler;
import watchedepisodes.thetvdbapi.xmlparser.handlers.SeriesHandler;

public class RequestFactory {
	private String baseURL;
	private String apiKey; 
	
	public RequestFactory (String baseURL, String apiKey) {
		this.baseURL = baseURL;
		this.apiKey = apiKey;
	}
	
	Request<Series> getGetSeriesRequest (String seriesId, String language) {
		String URL = baseURL + apiKey + "/series/" + seriesId + "/" + language + ".xml";
		Request<Series> request = new Request<Series>(URL, new SeriesHandler());
		return request;
	}
	
	Request<List<Episode>> getGetAllEpisodesRequest (String seriesId, String language) {
		String URL = baseURL + apiKey + "/series/" + seriesId + "/all/" + language + ".xml";
		Request<List<Episode>> request = new Request<List<Episode>>(URL, new EpisodesHandler()); 
		return request;
	}
	
	Request<List<SeriesFragment>> getSearchSeriesRequest(String searchString, String language) {
		String seriesName;
		
		try {
			seriesName = URLEncoder.encode(searchString, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			seriesName = searchString;
		}
		
		String URL = baseURL + "GetSeries.php?seriesname=" + seriesName + "&language=" + language;
		Request<List<SeriesFragment>> request = new Request<List<SeriesFragment>>(URL, new SearchResultsHandler());
		return request;
	}
	
	String getValidLanguage (String language) {
		return (language == null || language == "") ? "en" :  language;
	}
}
