package watchedepisodes.thetvdb;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.SAXException;

import watchedepisodes.entities.SeriesFragment;

public class TVDB {
	static private final String BaseURL= "http://www.thetvdb.com/api/";
	static private final String SearchURL= BaseURL + "GetSeries.php?seriesname=";
	
	private String apiKey;
	private SAXParser parser;
	
	public TVDB (String apiKey) {
		this.apiKey= apiKey;
	}
	
	public List<SeriesFragment> searchSeries (String searchString, String language) {
		String url= getSearchURL(searchString, language);
		InputStream xml= fetchURL(url);	
		SearchResultsHandler contentHandler= new SearchResultsHandler();
			
		try {
			getParser().parse(xml, contentHandler);
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				xml.close();
			} catch (IOException e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
		}
		
		return contentHandler.getResult();
	}
	
	private SAXParser getParser () {
		if (parser == null) {
			SAXParserFactory factory = SAXParserFactory.newInstance();
			try {
				parser= factory.newSAXParser();
			} catch (ParserConfigurationException e) {
				e.printStackTrace();
			} catch (SAXException e) {
				e.printStackTrace();
			}
		} else {
			parser.reset();
		}
		return parser;
	}
	
	private String getSearchURL (String searchString, String language) {
		String languageParameter= (language == null) ? "" : "&language=" + language;
		
		try {
			return SearchURL + URLEncoder.encode(searchString, "UTF-8") + languageParameter;
		} catch (UnsupportedEncodingException e) {
			return SearchURL + searchString;
		}
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
