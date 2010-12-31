package watchedepisodes.tools;

import com.moviejukebox.thetvdb.TheTVDB;

public class ServiceLocator {
	static private TheTVDB tvdb;
	
	static public TheTVDB getTVDBInstance () {
		if (tvdb == null) {
			// TODO: Get an API-Key
			tvdb= new TheTVDB("0629B785CE550C8D");
		}
		return tvdb;
	}
}
