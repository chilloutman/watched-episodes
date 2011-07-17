package watchedepisodes.servlets;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.protobuf.GeneratedMessage;

@SuppressWarnings("serial")
abstract class AbstractServlet extends HttpServlet {
	protected final String ProtocolBuffers = "application/x-protobuf";
	protected final String Html = "text/html";

	String getLanguage (HttpServletRequest request) {
		String language = request.getParameter("lang");
		if (language == null) {
			language = "en";
		}
		return language;
	}

	boolean clientAcceptsProtocolBuffers (HttpServletRequest request) {
		return (request.getHeader("Accept").equalsIgnoreCase(ProtocolBuffers));
	}

	boolean clientWantsDebugData (HttpServletRequest request) {
		return (request.getParameter("debug") != null);
	}

	void writeProtobufResponse (HttpServletResponse response, GeneratedMessage message) {
		try {
			response.setContentType(ProtocolBuffers);
			response.setBufferSize(message.getSerializedSize());
			message.writeTo(response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
			response.setStatus(500);
		}
	}

	void writeHtmlResponse (HttpServletResponse response, String html) {
		try {
			response.setContentType(Html);
			response.getWriter().append(html);
		} catch (IOException e) {
			e.printStackTrace();
			response.setStatus(500);
		}
	}
}
