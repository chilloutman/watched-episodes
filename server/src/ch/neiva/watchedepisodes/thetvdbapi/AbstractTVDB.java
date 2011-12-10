package ch.neiva.watchedepisodes.thetvdbapi;


abstract class AbstractTVDB <SearchType, SeriesType, EpisodesType> {
	// TODO: Use the api to get mirrors
	private static final String BaseURL= "http://www.thetvdb.com/api/";
	protected URLFactory URLFactory; 
	protected RequestAgent agent;
	
	
	public AbstractTVDB (String apiKey) {
		this.URLFactory = new URLFactory(BaseURL, apiKey);
		this.agent = new RequestAgent();
	}
	
	abstract public SearchType searchSeries (String searchString, String language) throws TVDBException;
	
	abstract public SeriesType getSeries (String id, String language) throws TVDBException;
	
	abstract public EpisodesType getAllEpisodes (String seriesId, String language) throws TVDBException;
}
