package watchedepisodes.entities;

import watchedepisodes.servlets.protocols.GetSeriesProtocol.GetSeriesResponse;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

public class KeyMaster {
	private static final String separator = "|";
	
	public static Key getKeyForCachedGetSeriesResponse (String id, String language) {
		String keyString = GetSeriesResponse.class.getSimpleName() + separator + id + separator + language;
		return KeyFactory.createKey(CachedResponse.class.getSimpleName(), keyString);
	} 
}
