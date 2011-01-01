package watchedepisodes.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.thetvdb.TVDB;
import watchedepisodes.tools.ServiceLocator;

@SuppressWarnings("serial")
public class SearchSeries extends HttpServlet {
	
	public void doGet (HttpServletRequest req, HttpServletResponse resp) {
		String seriesName= req.getParameter("name");
		if (seriesName == null) {
			return;
		}
		String language= req.getParameter("lang");
		if (language == null) {
			language= "en";
		}
		
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		List<SeriesFragment> results= tvdb.searchSeries(seriesName, language);
		
		printHumanReadableList(resp, results);
	}
	
	private void printHumanReadableList (HttpServletResponse resp, List<SeriesFragment> results) {
		resp.setContentType("text/html");
		try {
			resp.getWriter().println("<h1>Search Results:</h1>");
			for (SeriesFragment s : results) {
				resp.getWriter().println(s.getId() + " -> " + s.getName() + "<br />");
			}
		} catch (IOException e) {
			System.err.println(e);
		}
	}
}
