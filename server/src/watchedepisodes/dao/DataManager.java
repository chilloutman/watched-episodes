package watchedepisodes.dao;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;

import watchedepisodes.entities.CachedResponse;
import watchedepisodes.entities.Series;
import watchedepisodes.servlets.protocols.GetSeriesProtocol.GetSeriesResponse;
import watchedepisodes.thetvdbapi.ProtobufTVDB;
import watchedepisodes.thetvdbapi.TVDBException;
import watchedepisodes.tools.ServiceLocator;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.protobuf.GeneratedMessage;
import com.google.protobuf.InvalidProtocolBufferException;

public class DataManager {	
	public Series getSeries (String id, String language) throws DataAccessException {
		PersistenceManager pm = ServiceLocator.getPersistenceManager();
		Key key = KeyFactory.createKey(Series.class.getSimpleName(), id + language);
		
		try {
			return pm.getObjectById(Series.class, key);
		} catch (JDOObjectNotFoundException e) {
			return pm.makePersistent(fetchUncachedSeries(id, language));
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
		return series;
	}
	
	public GeneratedMessage getGetSeriesMessage (String id, String language, boolean withDebugData) throws DataAccessException {
		PersistenceManager pm = ServiceLocator.getPersistenceManager();
		Key key = KeyFactory.createKey(CachedResponse.class.getSimpleName(), id + language);
		GeneratedMessage message = null;
		try {
			byte[] messageBytes = loadMessageBytesFromCache(pm, key);
			GetSeriesResponse.Builder builder = GetSeriesResponse.newBuilder();
			try {
				builder.mergeFrom(messageBytes);				
			} catch (InvalidProtocolBufferException e) {
				throw new DataAccessException();
			}
			message = builder.build();
		} catch (DataAccessException e) {
			message = fetchUncachedGetSeriesMessage(id, language, withDebugData);
			writeMessageBytesToCache(pm, key, message);
		} finally {
			pm.close();
		}
		return message;
	}
	
	private GeneratedMessage fetchUncachedGetSeriesMessage (String id, String language, boolean withDebugData) throws DataAccessException {
		ProtobufTVDB tvdb = ServiceLocator.getProtobufTVDB(withDebugData);
		GeneratedMessage message;
		try {
			message = tvdb.getSeries(id, language);
		} catch (TVDBException e) {
			throw new DataAccessException();
		}
		return message;
	}
	
	private byte[] loadMessageBytesFromCache (PersistenceManager pm, Key key) throws DataAccessException {
		try {
			return pm.getObjectById(CachedResponse.class, key).getMessageBytes();
		} catch (JDOObjectNotFoundException e) {
			System.out.println("Message for key " + key.getName() + " is not cached");
			throw new DataAccessException();
		}
	}
	
	private void writeMessageBytesToCache (PersistenceManager pm, Key key, GeneratedMessage message) {
		CachedResponse response = new CachedResponse(key, message, "TODO");
		pm.makePersistent(response);
	}
}
