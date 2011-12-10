package ch.neiva.watchedepisodes.thetvdbapi;


import ch.neiva.watchedepisodes.thetvdbapi.xmlparser.handlers.UpdatesHandler;
import ch.neiva.watchedepisodes.thetvdbapi.xmlparser.protobuf.EpisodesHandler;
import ch.neiva.watchedepisodes.thetvdbapi.xmlparser.protobuf.SearchHandler;
import ch.neiva.watchedepisodes.thetvdbapi.xmlparser.protobuf.SeriesHandler;

import com.google.protobuf.GeneratedMessage;

public class ProtobufTVDB extends AbstractTVDB <GeneratedMessage, GeneratedMessage, GeneratedMessage> {

	public ProtobufTVDB (String apiKey) {
		super(apiKey);
	}
	
	@Override
	public GeneratedMessage searchSeries (String searchString, String language) throws TVDBException {
		String URL = URLFactory.getSearchSeriesURL(searchString, language);
		Request<GeneratedMessage> request = new Request<GeneratedMessage>(URL, new SearchHandler());
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
	
	@Override
	public GeneratedMessage getSeries (String id, String language) throws TVDBException {
		String URL = URLFactory.getGetSeriesURL(id, language);
		Request<GeneratedMessage> request = new Request<GeneratedMessage>(URL, new SeriesHandler());
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
	
	@Override
	public GeneratedMessage getAllEpisodes (String seriesId, String language) throws TVDBException {
		String URL = URLFactory.getGetAllEpisodesURL(seriesId, language);
		Request<GeneratedMessage> request = new Request<GeneratedMessage>(URL, new EpisodesHandler(seriesId));
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
	
	public TVDBUpdates getUpdates (long unixTime) throws TVDBException {
		String URL = URLFactory.getGetUpdatesURL(unixTime);
		Request<TVDBUpdates> request = new Request<TVDBUpdates>(URL, new UpdatesHandler());
		agent.performRequest(request);
		return request.getHandler().getResult();
	}
}
