package watchedepisodes.thetvdbapi;

import chilloutman.xmlparser.SAXHandler;


abstract class AbstractRequest<ReturnType> implements TVDBRequest {
	protected SAXHandler<ReturnType> handler;
	protected String baseURL;
	protected String language;
	
	protected AbstractRequest(String baseURL, String language) {
		this.baseURL= baseURL;
		this.language= (language == null || language == "") ? "en" : language;
	}
	
	@Override
	public SAXHandler<ReturnType> getHandler () {
		return handler;
	}
}
