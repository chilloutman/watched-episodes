package watchedepisodes.dao;

import java.util.List;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;

import watchedepisodes.entities.Episode;
import watchedepisodes.entities.Series;
import watchedepisodes.thetvdbapi.TVDBException;
import watchedepisodes.tools.ServiceLocator;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.repackaged.com.google.protobuf.Service;
import com.google.protobuf.GeneratedMessage;

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
	
	public List<Episode> getAllEpisodes (String seriesId, String language) throws DataAccessException {
		try {
			return ServiceLocator.getTVDBInstance().getAllEpisodes(seriesId, language);
		} catch (TVDBException e) {
			throw new DataAccessException();
		}
	}
	
	public GeneratedMessage getMessageWithSearchResults (String searchString, String language, boolean withDebugData) throws DataAccessException {
		try {
			return ServiceLocator.getProtobufTVDB(withDebugData).searchSeries(searchString, language);
		} catch (TVDBException e) {
			throw new DataAccessException();
		}
	}
	
	public GeneratedMessage getMessageWithSeries (String seriesId, String language, boolean withDebugData) {
		try {
			return ServiceLocator.getProtobufTVDB(withDebugData).getSeries(seriesId, language);
		} catch (TVDBException e) {
			
		}
		return null;
	}
	
	public GeneratedMessage getMessageWithAllEpisodes (String seriesId, String language, boolean withDebugData) throws DataAccessException {
		try {
			return ServiceLocator.getProtobufTVDB(withDebugData).getAllEpisodes(seriesId, language);
		} catch (TVDBException e) {
			throw new DataAccessException();
		}
	}
}
