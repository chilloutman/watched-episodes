package watchedepisodes.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.tools.ServiceLocator;

import com.google.appengine.repackaged.com.google.common.base.Service;
import com.moviejukebox.thetvdb.TheTVDB;
import com.moviejukebox.thetvdb.model.Series;

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
		
		TheTVDB tvdb= ServiceLocator.getTVDBInstance();
		List<Series> results= tvdb.searchSeries(seriesName, language);
		
		printHumanReadableList(resp, results);
	}
	
	private void printHumanReadableList (HttpServletResponse resp, List<Series> results) {
		resp.setContentType("text/html");
		try {
			resp.getWriter().println("<h1>Search Results:</h1>");
			for (Series s : results) {
				resp.getWriter().println(s.getSeriesName() + "<br />");
			}
		} catch (IOException e) {
			System.err.println(e);
		}
	}
}
