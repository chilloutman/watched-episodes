package ch.neiva.watchedepisodes.servlets;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import ch.neiva.watchedepisodes.entities.SeriesFragment;
import ch.neiva.watchedepisodes.thetvdbapi.ProtobufTVDB;
import ch.neiva.watchedepisodes.thetvdbapi.TVDBException;
import ch.neiva.watchedepisodes.tools.ServiceLocator;

import com.google.protobuf.GeneratedMessage;

@SuppressWarnings("serial")
public class SearchSeriesServlet extends AbstractServlet {
	private String searchString;
	private String language;
	
	@Override
	public void doGet (HttpServletRequest request, HttpServletResponse response) {
		searchString = getSeriesName(request);
		language = getLanguage(request);
		if (clientAcceptsProtocolBuffers(request)) {
			try {
				ProtobufTVDB tvdb = ServiceLocator.getProtobufTVDB(clientWantsDebugData(request));
				GeneratedMessage message = tvdb.searchSeries(searchString, language);
				writeProtobufResponse(response, message);
			} catch (TVDBException e) {
				response.setStatus(500);
				// TODO: Return error description
			}
		} else {
			writeHtmlResponse(response, getHTML());
		}
	}

	private String getSeriesName (HttpServletRequest request) {
		String seriesName = request.getParameter("name");
		if (seriesName == null) {
			// TODO handle invalid request
		}
		return seriesName;
	}

	private String getHTML () {
		StringBuilder builder = new StringBuilder();
		try {
			List<SeriesFragment> results = ServiceLocator.getTVDBInstance().searchSeries(searchString, language);
			builder.append("<h1>Search Results: </h1>");
			for (SeriesFragment s : results) {
				builder.append((s.getId() + " -> " + s.getName() + "<br />"));
			}
		} catch (TVDBException e) {
			builder.append("An error occured in the while trying to acces TheTVDB");
		}
		return builder.toString();
	}
}
