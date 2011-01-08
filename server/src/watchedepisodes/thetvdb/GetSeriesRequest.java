package watchedepisodes.thetvdb;

import watchedepisodes.entities.Series;
import watchedepisodes.thetvdb.xmlparser.SeriesHandler;

class GetSeriesRequest extends AbstractRequest<Series> {
	
	private String apiKey;
	private String id;
	
	GetSeriesRequest (String baseURL, String apiKey, String id, String language) {
		super(baseURL, language);
		this.apiKey= apiKey;
		this.id= id;
		this.handler= new SeriesHandler();
	}
	
	@Override
	public String getURL () {
		return baseURL + apiKey + "/series/" + id + "/" + language + ".xml";
	}
}
