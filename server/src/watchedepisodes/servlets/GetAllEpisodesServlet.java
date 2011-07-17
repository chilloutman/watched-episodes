package watchedepisodes.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.dao.DataAccessException;
import watchedepisodes.dao.DataManager;
import watchedepisodes.entities.Episode;
import watchedepisodes.tools.ServiceLocator;

import com.google.protobuf.GeneratedMessage;

@SuppressWarnings("serial")
public class GetAllEpisodesServlet extends AbstractServlet {
	private String seriesId;
	private String language;
	private boolean protobuf;

	@Override
	protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		seriesId = request.getParameter("id");
		language = getLanguage(request);
		protobuf = clientAcceptsProtocolBuffers(request);

		try {
			if (protobuf) {
				DataManager dataManager = ServiceLocator.getDataManager();
				GeneratedMessage messange = dataManager.getMessageWithAllEpisodes(seriesId, language, clientWantsDebugData(request));
				writeProtobufResponse(response, messange);
			} else {
				List<Episode> episodes = ServiceLocator.getDataManager().getAllEpisodes(seriesId, language);
				writeHtmlResponse(response, getHtml(episodes));
			}
		} catch (DataAccessException e) {
			response.setStatus(500);
		}
	}

	private String getHtml (List<Episode> episodes) {
		StringBuilder html = new StringBuilder();

		if (episodes == null || episodes.isEmpty()) {
			html.append("Could not get episodes for seriesId:" + seriesId);
		} else {
			int currentSeason = -1;
			for (Episode e : episodes) {
				if (e.getSeasonNumber() != currentSeason) {
					html.append("<h3>Season " + e.getSeasonNumber() + ":</h3>");
					currentSeason = e.getSeasonNumber();
				}

				html.append("Episode number: " + e.getEpisodeNumber() + "<br />");
				html.append("Episode name: " + e.getEpisodeName() + "<br />");
				html.append("Rating: " + e.getRating() + "<br />");
				html.append("overview: " + e.getOverview().getValue() + "<br />");
				html.append("<br />");
			}
		}

		return html.toString();
	}
}
