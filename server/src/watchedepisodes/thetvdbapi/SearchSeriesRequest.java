package watchedepisodes.thetvdbapi;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.thetvdbapi.xmlparser.SearchResultsHandler;

class SearchSeriesRequest extends AbstractRequest<List<SeriesFragment>> {
	
	private static final String SearchLocation= "GetSeries.php?seriesname=";
	private String searchString;
	
	SearchSeriesRequest(String baseURL, String searchString, String language) {
		super(baseURL, language);
		this.searchString= searchString;
		this.handler= new SearchResultsHandler();
	}
	
	@Override
	public String getURL () {
		String languageParameter= (language == null) ? "" : "&language=" + language;
		
		try {
			return baseURL + SearchLocation + URLEncoder.encode(searchString, "UTF-8") + languageParameter;
		} catch (UnsupportedEncodingException e) {
			return baseURL + SearchLocation + searchString;
		}
	}
}
