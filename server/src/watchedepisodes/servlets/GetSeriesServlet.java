package watchedepisodes.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.dao.DataAccessException;
import watchedepisodes.entities.Series;
import watchedepisodes.thetvdbapi.ProtobufTVDB;
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
		
		try {
			if (clientAcceptsProtocolBuffers(request)) {
				ProtobufTVDB tvdb = ServiceLocator.getProtobufTVDB(clientAcceptsProtocolBuffers(request));
				GeneratedMessage message = tvdb.getSeries(id, language);
				writeProtobufResponse(response, message);
			} else {
				Series series = ServiceLocator.getDataManager().getSeries(id, language);
				writeHtmlResponse(response, getHtml(series));
			}
		} catch (DataAccessException e) {
			response.setStatus(500);
		} catch (TVDBException e) {
			response.setStatus(500); 
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
