package watchedepisodes.thetvdb;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import watchedepisodes.entities.Series;
import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.thetvdb.xmlparser.SearchResultsHandler;
import watchedepisodes.thetvdb.xmlparser.SeriesHandler;
import watchedepisodes.thetvdb.xmlparser.ParseException;
import watchedepisodes.thetvdb.xmlparser.TVDBParser;

public class TVDB {
	private static final String BaseURL= "http://www.thetvdb.com/api/";
	private static final String SearchURL= BaseURL + "GetSeries.php?seriesname=";
	
	private String apiKey;
	private TVDBParser parser= new TVDBParser();
	
	public TVDB (String apiKey) {
		this.apiKey= apiKey;
	}
	
	@SuppressWarnings("serial")
	public class TVDBException extends Exception { }
	
	public List<SeriesFragment> searchSeries (String searchString, String language) throws TVDBException {
		String url= getSearchURL(searchString, language);
		InputStream xml= fetchURL(url);	
		SearchResultsHandler handler= new SearchResultsHandler();
		try {
			parser.parse(xml, handler);
			return handler.getResult();
		} catch (ParseException e) {
			throw new TVDBException();
		}
		
	}
	
	private String getSearchURL (String searchString, String language) {
		String languageParameter= (language == null) ? "" : "&language=" + language;
		
		try {
			return SearchURL + URLEncoder.encode(searchString, "UTF-8") + languageParameter;
		} catch (UnsupportedEncodingException e) {
			return SearchURL + searchString;
		}
	}
	
	public Series getSeries (String id, String language) throws TVDBException {
		String url= getSeriesURL(id, language);
		InputStream xml= fetchURL(url);
		SeriesHandler handler= new SeriesHandler();
		
		try {
			parser.parse(xml, handler);
			return handler.getResult();
		} catch (ParseException e) {
			throw new TVDBException();
		} finally {
			try {
				xml.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	private String getSeriesURL (String id, String language) {
		language= (language == null || language == "") ? "en" : language;
		return BaseURL + apiKey + "/series/" + id + "/" + language + ".xml";
	}
	
	private InputStream fetchURL (String url) throws TVDBException {
		try {
			return new URL(url).openStream();
		} catch (MalformedURLException e) {
			e.printStackTrace();
			throw new TVDBException();
		} catch (IOException e) {
			e.printStackTrace();
			throw new TVDBException();
		}
	}
}
