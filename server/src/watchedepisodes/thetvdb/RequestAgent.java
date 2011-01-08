package watchedepisodes.thetvdb;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;

import watchedepisodes.thetvdb.xmlparser.ParseException;
import watchedepisodes.thetvdb.xmlparser.TVDBParser;

class RequestAgent {
	
	private TVDBParser parser= new TVDBParser();
	
	void performRequest (TVDBRequest request) throws TVDBException {
		InputStream xml= fetchURL(request.getURL());	
		try {
			parser.parse(xml, request.getHandler());
		} catch (ParseException e) {
			throw new TVDBException();
		} finally {
			try {
				xml.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	private InputStream fetchURL (String url) throws TVDBException {
		try {
			return new URL(url).openStream();
		} catch (MalformedURLException e) {
			e.printStackTrace();
			throw new TVDBException();
		} catch (IOException e) {
			e.printStackTrace();
			throw new TVDBException();
		}
	}
}