package watchedepisodes.thetvdbapi;

import org.xml.sax.helpers.DefaultHandler;

interface TVDBRequest {
	String getURL ();
	DefaultHandler getHandler ();
}
