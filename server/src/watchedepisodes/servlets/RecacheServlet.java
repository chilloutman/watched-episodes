package watchedepisodes.servlets;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.entities.ApplicationProperties;
import watchedepisodes.entities.CachedResponse;
import watchedepisodes.entities.KeyMaster;
import watchedepisodes.thetvdbapi.ProtobufTVDB;
import watchedepisodes.thetvdbapi.TVDBException;
import watchedepisodes.thetvdbapi.TVDBUpdates;
import watchedepisodes.tools.ServiceLocator;

import com.google.appengine.api.datastore.Key;

@SuppressWarnings("serial")
public class RecacheServlet extends AbstractServlet {
	
	@Override
	protected void doGet (HttpServletRequest request, HttpServletResponse response) {
		PersistenceManager pm = ServiceLocator.getPersistenceManager();
		try {
			ApplicationProperties properties = ServiceLocator.getApplicationProperties(pm);
			
			if (previousTimeHasExpired(properties.getPreviousRecacheTime())) {
				properties.setPreviousRecacheTime(currentUnixTime());
				invalidateEntireCache(pm);
			} else {
				long time = recache(pm, properties.getPreviousRecacheTime());
				properties.setPreviousRecacheTime(time);
			}
		} catch (TVDBException e) {
			response.setStatus(500);
		} finally {
			pm.close();
		}
	}
	
	private boolean previousTimeHasExpired (long time) {
		long thirtyDaysAgo = currentUnixTime() - 2592000;
		return (time < thirtyDaysAgo);
	}
	
	private long currentUnixTime () {
		return System.currentTimeMillis() / 1000L;
	}
	
	private void invalidateEntireCache (PersistenceManager pm) {
		Query query = pm.newQuery(CachedResponse.class);
		query.deletePersistentAll();
	}
	
	private long recache (PersistenceManager pm, long time) throws TVDBException {
		ProtobufTVDB tvdb = ServiceLocator.getProtobufTVDB(false);
		TVDBUpdates updates = tvdb.getUpdates(time);
		for (String seriesId : updates.getUpdatedSeriesIds()) {
			// TODO Do this for every language?
			String language = "en";
			Key key = KeyMaster.getKeyForCachedGetSeriesResponse(seriesId, language);
			try {
				CachedResponse response = pm.getObjectById(CachedResponse.class, key);
				response.setMessage(tvdb.getSeries(seriesId, language));
				response.setUnixTime(time);
				System.out.println("Recached response with id " + key.getName());
			} catch (JDOObjectNotFoundException e) {
				// Ignore
			}
		}
		return updates.getUnixTime();
	}
}
