package watchedepisodes.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.dao.DataAccessException;
import watchedepisodes.dao.DataManager;
import watchedepisodes.entities.Series;
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
			writeResponse(request, response);
		} catch (DataAccessException e) {
			response.setStatus(500);
		}
	}
	
	private void writeResponse (HttpServletRequest request, HttpServletResponse response) throws DataAccessException {
		DataManager dataManager = ServiceLocator.getDataManager();
		if (clientAcceptsProtocolBuffers(request)) {
			GeneratedMessage message = dataManager.getGetSeriesMessage(id, language, clientWantsDebugData(request));
			writeProtobufResponse(response, message);
		} else {
			Series series = dataManager.getSeries(id, language);
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
