package watchedepisodes.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.dao.DataAccessException;
import watchedepisodes.entities.Series;
import watchedepisodes.servlets.protocols.ProtocolFactory;
import watchedepisodes.tools.ServiceLocator;

import com.google.protobuf.GeneratedMessage;

@SuppressWarnings("serial")
public class GetSeriesServlet extends AbstractServlet {
	
	private String id;
	private String language;
	private boolean protobuf;
	
	public void doGet (HttpServletRequest request, HttpServletResponse response) {
		id = request.getParameter("id");
		language = getLanguage(request);
		protobuf = clientAcceptsProtocolBuffers(request);
		
		Series series;
		try {
			series = ServiceLocator.getDataManager().getSeries(id, language);
			writeResponse(response, series);
		} catch (DataAccessException e) {
			response.setStatus(500);
		}
	}
	
	private void writeResponse (HttpServletResponse response, Series series) {
		if (protobuf) {
			GeneratedMessage message = ProtocolFactory.buildGetSeriesResponse(series);
			writeProtobufResponse(response, message);
		} else {
			writeHtmlResponse(response, getHtml(series));
		}
	}
	
	private String getHtml (Series series) {
		StringBuilder html = new StringBuilder();
		
		if (series == null) {
			html.append("Could not get series with this id:" + id);
		} else {
			html.append("<h1>Series Info:</h1>");
			
			html.append("id: " + series.getId() + "<br />");
			html.append("name: " + series.getName() + "<br />");
			for (String a : series.getActors()) {
				html.append("<t />Actor: " + a  + "<br />");
			}
			html.append("first aired: " + series.getFirstAired() + "<br />");
			html.append("banner: " + series.getBanner() + "<br />");
			html.append("imdb: " + series.getImdbId() + "<br />");
			html.append("overview: " + series.getOverview().getValue() + "<br />");
		}
		
		return html.toString();
	}
}
