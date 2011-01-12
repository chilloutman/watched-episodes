package watchedepisodes.servlets;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;


@SuppressWarnings("serial")
abstract class AbstractServlet extends HttpServlet {
	protected final String protocolBuffers= "application/x-protobuf";
	protected final String Html= "text/html";
	
	protected String getLanguage (HttpServletRequest request) {
		String language= request.getParameter("lang");
		if (language == null) {
			language= "en";
		}
		return language;
	}
	
	protected boolean clientAcceptsProtocolBuffers (HttpServletRequest request) {
		System.out.println("Accept: "+ request.getHeader("Accept"));
		return (request.getHeader("Accept").equalsIgnoreCase(protocolBuffers));
	}
}
