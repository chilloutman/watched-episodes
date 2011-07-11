package watchedepisodes.thetvdbapi;

import org.xml.sax.helpers.DefaultHandler;

public interface XMLRequest {
	DefaultHandler getHandler ();
	String getURL ();
}
