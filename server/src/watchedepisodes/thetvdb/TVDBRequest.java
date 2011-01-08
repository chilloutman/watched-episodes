package watchedepisodes.thetvdb;

import org.xml.sax.helpers.DefaultHandler;

interface TVDBRequest {
	String getURL ();
	DefaultHandler getHandler ();
}
