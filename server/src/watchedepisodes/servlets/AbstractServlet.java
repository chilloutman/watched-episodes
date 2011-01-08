package watchedepisodes.servlets;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;


@SuppressWarnings("serial")
abstract class AbstractServlet extends HttpServlet {
	protected String language;
	protected ResponseType responseType;
	
	protected enum ResponseType {
		ProtocolBuffers,
		Html
	};
	
	protected void getParameters(HttpServletRequest request) {
		language= request.getParameter("lang");
		if (language == null) {
			language= "en";
		}
		
		String type= request.getParameter("t");
		if (type == null) {
			responseType= ResponseType.Html;
		} else if (type == "protobuf") {
			responseType= ResponseType.ProtocolBuffers;
		}
	}
}
