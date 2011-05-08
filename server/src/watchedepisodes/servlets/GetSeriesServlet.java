package watchedepisodes.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.entities.Series;
import watchedepisodes.servlets.protocols.ProtocolFactory;
import watchedepisodes.thetvdbapi.TVDBException;
import watchedepisodes.tools.ServiceLocator;

import com.google.protobuf.GeneratedMessage;

@SuppressWarnings("serial")
public class GetSeriesServlet extends AbstractServlet {
	
	private String id;
	private String language;
	
	public void doGet (HttpServletRequest request, HttpServletResponse response) {
		id = request.getParameter("id");
		language = getLanguage(request);
		
		Series series;
		try {
			series = ServiceLocator.getDataManager().getSeries(id, language);
			writeResponse(request, response, series);
		} catch (TVDBException e) {
			e.printStackTrace();
			response.setStatus(500);
		}		
	}
	
	private void writeResponse (HttpServletRequest request, HttpServletResponse response, Series series) {
		if (clientAcceptsProtocolBuffers(request)) {
			GeneratedMessage message = ProtocolFactory.buildGetSeriesProto(series);
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
