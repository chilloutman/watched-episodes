package watchedepisodes.servlets;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;


@SuppressWarnings("serial")
abstract class AbstractServlet extends HttpServlet {
	protected String language;
	protected String responseType;
	
	protected class ResponseTypes {
		static final String ProtocolBuffers= "protobuf";
		static final String Html= "html";
	}
	
	protected void getParameters(HttpServletRequest request) {
		language= request.getParameter("lang");
		// TODO: Check if language is supported here or somewhere esle?
		if (language == null) {
			language= "en";
		}
		
		String type= request.getParameter("t");
		if (type.equals(ResponseTypes.ProtocolBuffers)) {
			responseType= ResponseTypes.ProtocolBuffers;
		} else {
			responseType= ResponseTypes.Html;
		}
	}
}
