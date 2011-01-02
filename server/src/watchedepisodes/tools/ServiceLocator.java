package watchedepisodes.tools;

import javax.jdo.JDOHelper;
import javax.jdo.PersistenceManagerFactory;

import watchedepisodes.thetvdb.TVDB;

public class ServiceLocator {
	private static final TVDB tvdb= new TVDB("0629B785CE550C8D");
	private static final PersistenceManagerFactory pmf= JDOHelper.getPersistenceManagerFactory("transactions-optional");
	
	private ServiceLocator() { }
	
	public static TVDB getTVDBInstance () {
		return tvdb;
	}
	
	public static PersistenceManagerFactory getPersistenceManagerFactory () {
		return pmf;
	}
}
