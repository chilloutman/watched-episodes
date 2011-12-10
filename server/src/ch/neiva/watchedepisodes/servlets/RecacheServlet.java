package ch.neiva.watchedepisodes.servlets;

import java.io.IOException;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import ch.neiva.watchedepisodes.entities.ApplicationProperties;
import ch.neiva.watchedepisodes.entities.CachedResponse;
import ch.neiva.watchedepisodes.entities.KeyMaster;
import ch.neiva.watchedepisodes.thetvdbapi.ProtobufTVDB;
import ch.neiva.watchedepisodes.thetvdbapi.TVDBException;
import ch.neiva.watchedepisodes.thetvdbapi.TVDBUpdates;
import ch.neiva.watchedepisodes.tools.ServiceLocator;

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
				try {
					response.getWriter().append("Returned time: " + time + "<br />");
				} catch (IOException e) {
					e.printStackTrace();
				}
				properties.setPreviousRecacheTime(time);
			}
		} catch (TVDBException e) {
			response.setStatus(500);
		} finally {
			pm.close();
		}
		
		try {
			response.getWriter().append("" + System.currentTimeMillis() / 1000L);
		} catch (IOException e) {
			e.printStackTrace();
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
				response.setUnixTime(updates.getUnixTime());
				System.out.println("Recached response with id " + key.getName());
			} catch (JDOObjectNotFoundException ignore) { }
		}
		return updates.getUnixTime();
	}
}
