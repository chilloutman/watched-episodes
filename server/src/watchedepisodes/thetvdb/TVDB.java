package watchedepisodes.thetvdb;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import watchedepisodes.entities.SeriesFragment;

public class TVDB {
	static private final String BaseURL= "http://www.thetvdb.com/api/";
	static private final String SearchURL= BaseURL + "GetSeries.php?seriesname=";
	
	private String apiKey;
	
	public TVDB (String apiKey) {
		this.apiKey= apiKey;
	}
	
	public List<SeriesFragment> searchSeries (String searchString, String language) {
		InputStream xml= getInputStream(getSearchURL(searchString, language));	
		SearchResultsHandler contentHandler= new SearchResultsHandler();
		
		System.out.println(getSearchURL(searchString, language));
		
		SAXParserFactory factory = SAXParserFactory.newInstance();
			
		try {
			SAXParser parser = factory.newSAXParser();
	        parser.parse(xml, contentHandler);
		} catch (Exception e) {
		    e.printStackTrace();
		} finally {
			try {
				xml.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return contentHandler.getResult();
	}
	
	private String getSearchURL (String searchString, String language) {
		String languageParameter= (language == null) ? "" : "&language=" + language;
		
		try {
			return SearchURL + URLEncoder.encode(searchString, "UTF-8") + languageParameter;
		} catch (UnsupportedEncodingException e) {
			return SearchURL + searchString;
		}
	}
	
	private InputStream getInputStream (String url) {
		try {
			return new URL(url).openStream();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
