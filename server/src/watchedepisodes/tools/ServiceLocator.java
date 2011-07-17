package watchedepisodes.tools;

import javax.jdo.JDOHelper;
import javax.jdo.PersistenceManager;
import javax.jdo.PersistenceManagerFactory;

import watchedepisodes.dao.DataManager;
import watchedepisodes.thetvdbapi.OfflineTVDB;
import watchedepisodes.thetvdbapi.TVDB;
import watchedepisodes.thetvdbapi.ProtobufTVDB;

public abstract class ServiceLocator {
	private static TVDB tvdb;
	private static ProtobufTVDB protobufTVDB;
	private static ProtobufTVDB offlineTVDB;
	private static PersistenceManagerFactory pmf;
	private static final DataManager dataManager = new DataManager();
	
	private ServiceLocator() { }
	
	public static TVDB getTVDBInstance () {
		if (tvdb == null) tvdb = new TVDB("0629B785CE550C8D");
		return tvdb;
	}
	
	public static ProtobufTVDB getProtobufTVDB (boolean withDebugData) {
		ProtobufTVDB tvdb;
		if (withDebugData) {
			tvdb = getOfflineTVDB();
		} else {
			if (protobufTVDB == null) protobufTVDB = new ProtobufTVDB("0629B785CE550C8D");
			tvdb = protobufTVDB;
		}
		return tvdb;
	}
	
	private static ProtobufTVDB getOfflineTVDB () {
		if (offlineTVDB == null) offlineTVDB = new OfflineTVDB("");
		return offlineTVDB;
	}
	
	public static PersistenceManager getPersistenceManager () {
		if (pmf == null) pmf = JDOHelper.getPersistenceManagerFactory("transactions-optional");
		return pmf.getPersistenceManager();
	}
	
	public static DataManager getDataManager () {
		return dataManager;
	}
}
