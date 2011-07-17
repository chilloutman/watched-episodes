package watchedepisodes.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.entities.Episode;
import watchedepisodes.entities.Series;
import watchedepisodes.entities.SeriesFragment;
import watchedepisodes.thetvdbapi.TVDB;
import watchedepisodes.thetvdbapi.TVDBException;
import watchedepisodes.tools.ServiceLocator;

@SuppressWarnings("serial")
public class CheckTVDBServlet extends HttpServlet {
	
	public void doGet (HttpServletRequest req, HttpServletResponse resp) {
		resp.setContentType("text/html");
		StringBuilder html= new StringBuilder();
		
		try {
			searchSeries(html);
			getSeries(html);
			getAllEpisodes(html);
		} finally {
			try {
				resp.getWriter().append(html);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	private void searchSeries (StringBuilder html) {
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		List<SeriesFragment> results;
		
		html.append("<h1>Search for \" Simpsons\":</h1><br />");
		try {
			results = tvdb.searchSeries("Simpsons", "en");
			
			for (SeriesFragment s : results) {
				html.append(s.getId() + " -> " + s.getName() + "<br />");
			}
		} catch (TVDBException e) {
			html.append("<font color=\"red\">failed</font><br />");
		}
	}
	
	private void getSeries (StringBuilder html) {
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		html.append("<h1>Series Info:</h1>");
		
		try {
			Series s = tvdb.getSeries("82283", "en");
			
			html.append("id: " + s.getId() + "<br />");
			html.append("name: " + s.getName() + "<br />");
			html.append("Actors: ");
			for (String a : s.getActors()) {
				html.append(a  + ", ");
			}
			html.append("<br />");
			html.append("first aired: " + s.getFirstAired() + "<br />");
			html.append("banner: " + s.getBanner() + "<br />");
			html.append("imdb: " + s.getImdbId() + "<br />");
			html.append("overview: " + s.getOverview().getValue() + "<br />");
		} catch (TVDBException e) {
			html.append("<font color=\"red\">failed</font><br />");
		}
	}
	
	private void getAllEpisodes (StringBuilder html) {
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		html.append("<h1>All Episodes:</h1>");
		
		try {
			List<Episode> episodes= tvdb.getAllEpisodes("71663","en");
			
			int currentSeason= -1;
			for (Episode e : episodes) {
				if (e.getSeasonNumber() != currentSeason) {
					html.append("<h3>Season " + e.getSeasonNumber() + ":</h3>");
					currentSeason= e.getSeasonNumber();
				}
				
				html.append("Episode number: " + e.getEpisodeNumber() + "<br />");
				html.append("Episode name: " + e.getEpisodeName() + "<br />");
				html.append("Rating: " + e.getRating() + "<br />");
				html.append("overview: " + e.getOverview().getValue() + "<br />");
				html.append("<br />");
			}
		} catch (TVDBException e) {
			html.append(getFailMessage());
		} finally {
			
		}
	}
	
	private String getFailMessage () {
		return "<font color=\"red\">failed</font><br />";
	}
}
