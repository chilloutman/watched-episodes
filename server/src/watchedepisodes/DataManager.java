package watchedepisodes;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;

import watchedepisodes.entities.Series;
import watchedepisodes.thetvdbapi.TVDBException;
import watchedepisodes.tools.ServiceLocator;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

public class DataManager {
	
	public Series getSeries (String id, String language) throws TVDBException {
		PersistenceManager pm = ServiceLocator.getPersistenceManager();
		Key key= KeyFactory.createKey(Series.class.getSimpleName(), id + language);
		Series series = null;
		
		try {
			series = pm.getObjectById(Series.class, key);
		} catch (JDOObjectNotFoundException e) {
			series = ServiceLocator.getTVDBInstance().getSeries(id, language);
			pm.makePersistent(series);
		}
		
		pm.close();
		return series;
	}
}
