package watchedepisodes.servlets;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.servlets.protocols.ProtocolFactory;
import watchedepisodes.thetvdb.TVDB;
import watchedepisodes.thetvdb.TVDBException;
import watchedepisodes.tools.ServiceLocator;

import com.google.protobuf.GeneratedMessage;

@SuppressWarnings("serial")
public class SearchSeriesServlet extends AbstractServlet {	
	@Override
	public void doGet (HttpServletRequest request, HttpServletResponse response) {		
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		try {
			List<SeriesFragment> results= tvdb.searchSeries(getSeriesName(request), getLanguage(request));
			writeResponse(response, request, results);
		} catch (TVDBException e) {
			response.setStatus(500);
			// TODO: Return error description
		}
	}
	
	private String getSeriesName (HttpServletRequest request) {		
		String seriesName= request.getParameter("name");
		if (seriesName == null) {
			// TODO handle invalid request
		}
		return seriesName;
	}
	
	private void writeResponse (HttpServletResponse response, HttpServletRequest request, List<SeriesFragment> results) {
		if (clientAcceptsProtocolBuffers(request)) {
			writeProtobufResponse(response, getProtocolMessage(results));
		} else {
			writeHtmlResponse(response, getHtml(results));
		}
		
	}

	private GeneratedMessage getProtocolMessage (List<SeriesFragment> results) {
		return ProtocolFactory.buildSearchResultsProto(results);
	}
	
	private String getHtml (List<SeriesFragment> results) {
		StringBuilder builder= new StringBuilder();
		builder.append("<h1>Search Results:</h1>");
		for (SeriesFragment s : results) {
			builder.append((s.getId() + " -> " + s.getName() + "<br />"));
		}
		return builder.toString();
	}
}
