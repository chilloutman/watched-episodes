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
	
	private String seriesName;
	
	@Override
	public void doGet (HttpServletRequest request, HttpServletResponse response) {
		getParameters(request);
		
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		try {
			List<SeriesFragment> results = tvdb.searchSeries(seriesName, language);
			writeResponse(response, results);
		} catch (TVDBException e) {
			response.setStatus(500);
			// TODO: Return error description
		}
	}
	
	@Override
	protected void getParameters(HttpServletRequest request) {
		super.getParameters(request);
		
		seriesName= request.getParameter("name");
		if (seriesName == null) {
			return;
		}
	}
	
	private void writeResponse (HttpServletResponse response, List<SeriesFragment> results) {
		try {
			if (responseType.equals(ResponseTypes.ProtocolBuffers)) {
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
		response.setContentType("application/x-protobuf");
		
		PBSearchResults.Builder searchResults= PBSearchResults.newBuilder();
		
		for (SeriesFragment s : results) {
			PBSeries.Builder series= PBSeries.newBuilder();
			series.setId(s.getId());
			series.setName(s.getName());
			searchResults.addSeries(series);
		}
		
		response.setBufferSize(searchResults.build().getSerializedSize());
		searchResults.build().writeTo(response.getOutputStream());
	}
	
	private void writeHtml (HttpServletResponse response, List<SeriesFragment> results) throws IOException {
		response.setContentType("text/html");
		
		response.getWriter().println("<h1>Search Results:</h1>");
		for (SeriesFragment s : results) {
			response.getWriter().println(s.getId() + " -> " + s.getName() + "<br />");
		}
	}
}
