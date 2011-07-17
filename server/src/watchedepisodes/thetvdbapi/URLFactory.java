package watchedepisodes.thetvdbapi;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class URLFactory {
	private String baseURL;
	private String apiKey; 
	
	public URLFactory (String baseURL, String apiKey) {
		this.baseURL = baseURL;
		this.apiKey = apiKey;
	}
	
	protected String getGetSeriesURL (String seriesId, String language) {
		return baseURL + apiKey + "/series/" + seriesId + "/" + getValidLanguage(language) + ".xml";
	}
	
	protected String getGetAllEpisodesURL (String seriesId, String language) {
		return baseURL + apiKey + "/series/" + seriesId + "/all/" + getValidLanguage(language) + ".xml";
	}
	
	protected String  getSearchSeriesURL (String searchString, String language) {
		String seriesName;
		try {
			seriesName = URLEncoder.encode(searchString, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			seriesName = searchString;
		}
		
		return baseURL + "GetSeries.php?seriesname=" + seriesName + "&language=" + getValidLanguage(language);
	}
	
	private String getValidLanguage (String language) {
		return (language == null || language == "") ? "en" :  language;
	}
}
