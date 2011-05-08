package watchedepisodes.thetvdbapi;

import java.util.List;

import watchedepisodes.entities.Episode;
import watchedepisodes.thetvdbapi.xmlparser.EpisodesHandler;

class GetAllEpisodesRequest extends AbstractRequest<List<Episode>> {
	
	private String apiKey;
	private String seriesId;
	
	GetAllEpisodesRequest(String baseURL, String apiKey, String seriesId, String language) {
		super(baseURL, language);
		this.apiKey= apiKey;
		this.seriesId= seriesId;
		this.handler= new EpisodesHandler();
	}
	
	@Override
	public String getURL() {
		return baseURL + apiKey + "/series/" + seriesId + "/all/" + language + ".xml";
	}
}
