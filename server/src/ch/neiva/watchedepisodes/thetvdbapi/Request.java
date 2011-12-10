package ch.neiva.watchedepisodes.thetvdbapi;

import ch.neiva.xmlparser.SAXHandler;

class Request <ResponseType> implements XMLRequest {
	private SAXHandler<ResponseType> handler;
	private String URL;
	
	Request (String URL, SAXHandler<ResponseType> handler) {
		this.URL = URL;
		this.handler = handler;
	}
	
	public SAXHandler<ResponseType> getHandler () {
		return handler;
	}
	
	public String getURL () {
		return URL;
	}
}