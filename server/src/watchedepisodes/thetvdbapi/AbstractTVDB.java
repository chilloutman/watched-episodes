package watchedepisodes.thetvdbapi;

abstract class AbstractTVDB {
	// TODO: Use the api to get mirrors
	private static final String BaseURL= "http://www.thetvdb.com/api/";
	protected URLFactory URLFactory; 
	protected RequestAgent agent;
	
	
	public AbstractTVDB (String apiKey) {
		this.URLFactory = new URLFactory(BaseURL, apiKey);
		this.agent = new RequestAgent();
	}
}
