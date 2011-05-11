package watchedepisodes.dao;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;

import watchedepisodes.entities.Series;
import watchedepisodes.thetvdbapi.TVDBException;
import watchedepisodes.tools.ServiceLocator;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

public class DataManager {
	private PersistenceManager pm = null;
	
	public Series getSeries (String id, String language) throws DataAccessException {
		pm = ServiceLocator.getPersistenceManager();
		Key key= KeyFactory.createKey(Series.class.getSimpleName(), id + language);
		
		try {
			return pm.getObjectById(Series.class, key);
		} catch (JDOObjectNotFoundException e) {
			return fetchUncachedSeries(id, language);
		} finally {
			pm.close();
		}
	}
	
	private Series fetchUncachedSeries (String id, String language) throws DataAccessException {
		Series series = null;
		try {
			series = ServiceLocator.getTVDBInstance().getSeries(id, language);
		} catch (TVDBException e) {
			throw new DataAccessException();
		}
		return pm.makePersistent(series);
	}
}