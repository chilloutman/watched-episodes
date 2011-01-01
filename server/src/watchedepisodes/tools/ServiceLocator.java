package watchedepisodes.tools;

import watchedepisodes.thetvdb.TVDB;

public class ServiceLocator {
	static private TVDB tvdb;
	
	static public TVDB getTVDBInstance () {
		if (tvdb == null) {
			// TODO: Get an API-Key
			tvdb= new TVDB("0629B785CE550C8D");
		}
		return tvdb;
	}
}
