package watchedepisodes.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.entities.Series;
import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.thetvdb.TVDB;
import watchedepisodes.thetvdb.TVDB.TVDBException;
import watchedepisodes.tools.ServiceLocator;

@SuppressWarnings("serial")
public class CheckTVDB extends HttpServlet {
	
	public void doGet (HttpServletRequest req, HttpServletResponse resp) {
		resp.setContentType("text/html");
		
		try {
			searchSeries(resp);
			getSeries(resp);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private void searchSeries (HttpServletResponse resp) throws IOException {
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		List<SeriesFragment> results;
		
		resp.getWriter().append("<h1>Search for \" Simpsons\":</h1><br />");
		try {
			results = tvdb.searchSeries("Simpsons", "en");
			
			for (SeriesFragment s : results) {
				resp.getWriter().println(s.getId() + " -> " + s.getName() + "<br />");
			}
		} catch (TVDBException e) {
			resp.getWriter().append("<font color=\"red\">failed</font><br />");
		}
	}
	
	private void getSeries(HttpServletResponse resp) throws IOException {
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		StringBuilder html= new StringBuilder();
		html.append("<h1>Series Info:</h1>");
		
		try {
			Series s = tvdb.getSeries("82283", "en");
			
			html.append("id: " + s.getId() + "<br />");
			html.append("name: " + s.getName() + "<br />");
			html.append("Actors: ");
			for (String a : s.getActors()) {
				html.append(a  + ", ");
			}
			html.append("first aired: " + s.getFirstAired() + "<br />");
			html.append("banner: " + s.getBanner() + "<br />");
			html.append("imdb: " + s.getImdbId() + "<br />");
			html.append("overview: " + s.getOverview().getValue() + "<br />");
		} catch (TVDBException e) {
			html.append("<font color=\"red\">failed</font><br />");
		} finally {
			resp.getWriter().append(html);
		}
	}
}
