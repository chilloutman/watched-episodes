package watchedepisodes.thetvdb;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.entities.Series;

public class TVDB {
	static private final String BaseURL= "http://www.thetvdb.com/api/";
	static private final String SearchURL= BaseURL + "GetSeries.php?seriesname=";
	
	private String apiKey;
	private TVDBParser parser= new TVDBParser();
	
	public TVDB (String apiKey) {
		this.apiKey= apiKey;
	}
	
	public List<SeriesFragment> searchSeries (String searchString, String language) {
		String url= getSearchURL(searchString, language);
		InputStream xml= fetchURL(url);	
		SearchResultsHandler handler= new SearchResultsHandler();
		parser.parse(xml, handler);
		return handler.getResult();
	}
	
	private String getSearchURL (String searchString, String language) {
		String languageParameter= (language == null) ? "" : "&language=" + language;
		
		try {
			return SearchURL + URLEncoder.encode(searchString, "UTF-8") + languageParameter;
		} catch (UnsupportedEncodingException e) {
			return SearchURL + searchString;
		}
	}
	
	public Series getSeries (String id, String language) {
		String url= getSeriesURL(id, language);
		InputStream xml= fetchURL(url);
		SeriesHandler handler= new SeriesHandler();
		parser.parse(xml, handler);
		return handler.getResult();
	}
	
	private String getSeriesURL (String id, String language) {
		language= (language == null || language == "") ? "en" : language;
		return BaseURL + apiKey + "/series/" + id + "/" + language + ".xml";
	}
	
	private InputStream fetchURL (String url) {
		try {
			return new URL(url).openStream();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
