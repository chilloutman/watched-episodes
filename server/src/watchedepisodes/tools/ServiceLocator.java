package watchedepisodes.tools;

import javax.jdo.JDOHelper;
import javax.jdo.PersistenceManager;
import javax.jdo.PersistenceManagerFactory;

import watchedepisodes.dao.DataManager;
import watchedepisodes.thetvdbapi.TVDB;
import watchedepisodes.thetvdbapi.TVDBForProtobuf;

public abstract class ServiceLocator {
	private static final TVDB tvdb = new TVDB("0629B785CE550C8D");
	private static final TVDBForProtobuf tvdbForProtobuf = new TVDBForProtobuf("0629B785CE550C8D");
	private static final PersistenceManagerFactory pmf = JDOHelper.getPersistenceManagerFactory("transactions-optional");
	private static final DataManager dataManager = new DataManager();
	
	private ServiceLocator() { }
	
	public static TVDB getTVDBInstance () {
		return tvdb;
	}
	
	public static TVDBForProtobuf getTVDBForProtobuf () {
		return tvdbForProtobuf;
	}
	
	public static PersistenceManager getPersistenceManager () {
		return pmf.getPersistenceManager();
	}
	
	public static DataManager getDataManager () {
		return dataManager;
	}
}
