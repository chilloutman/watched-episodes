package watchedepisodes.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.servlets.protocols.SearchSeriesProtocol.PBSearchResults;
import watchedepisodes.servlets.protocols.SearchSeriesProtocol.PBSearchResults.PBSeries;
import watchedepisodes.thetvdb.TVDB;
import watchedepisodes.thetvdb.TVDBException;
import watchedepisodes.tools.ServiceLocator;

@SuppressWarnings("serial")
public class SearchSeriesServlet extends AbstractServlet {
	
	@Override
	public void doGet (HttpServletRequest request, HttpServletResponse response) {		
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		try {
			List<SeriesFragment> results = tvdb.searchSeries(getSeriesName(request), getLanguage(request));
			writeResponse(response, request, results);
		} catch (TVDBException e) {
			response.setStatus(500);
			// TODO: Return error description
		}
	}
	
	private String getSeriesName(HttpServletRequest request) {		
		String seriesName= request.getParameter("name");
		if (seriesName == null) {
			// TODO handle invalid request
		}
		return seriesName;
	}
	
	private void writeResponse (HttpServletResponse response, HttpServletRequest request, List<SeriesFragment> results) {
		try {
			if (clientAcceptsProtocolBuffers(request)) {
				writeProtobuf(response, results);
			} else {
				writeHtml(response, results);
			}
		} catch (IOException e) {
			e.printStackTrace();
			response.setStatus(500);
		}
	}
	
	private void writeProtobuf (HttpServletResponse response, List<SeriesFragment> results) throws IOException {
		response.setContentType(protocolBuffers);
		
		PBSearchResults.Builder searchResults= PBSearchResults.newBuilder();
		
		for (SeriesFragment s : results) {
			PBSeries.Builder series= PBSeries.newBuilder();
			series.setId(s.getId());
			series.setName(s.getName());
			searchResults.addSeries(series);
		}
		
		PBSearchResults protobuf= searchResults.build();
		response.setBufferSize(protobuf.getSerializedSize());
		protobuf.writeTo(response.getOutputStream());
	}
	
	private void writeHtml (HttpServletResponse response, List<SeriesFragment> results) throws IOException {
		response.setContentType(Html);
		
		response.getWriter().println("<h1>Search Results:</h1>");
		for (SeriesFragment s : results) {
			response.getWriter().println(s.getId() + " -> " + s.getName() + "<br />");
		}
	}
}
