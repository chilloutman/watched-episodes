package watchedepisodes.servlets;

import java.io.IOException;
import java.util.List;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.entities.Series;
import watchedepisodes.thetvdb.TVDB;
import watchedepisodes.tools.ServiceLocator;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("serial")
public class GetSeries extends HttpServlet {
	private String id;
	private String language;
	
	public void doGet (HttpServletRequest request, HttpServletResponse resp) {
		getParameters(request);
		
		PersistenceManager pm= ServiceLocator.getPersistenceManagerFactory().getPersistenceManager();
		Series series= null;
		Key key= KeyFactory.createKey(Series.class.getSimpleName(), id + language);
		
		try {
			series= pm.getObjectById(Series.class, key);
		} catch (JDOObjectNotFoundException e) {
			series= fetchSeriesFromTVDB();
			pm.makePersistent(series);
		}
		
		pm.close();
		
		// TODO: Remove debug html stuff
		resp.setContentType("text/html");
		try {
			if (series == null) {
				resp.getWriter().append("Could not get series with this id:" + id);
			} else {
				resp.getWriter().append(getHtml(series));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private void getParameters (HttpServletRequest request) {
		id= request.getParameter("id");
		if (id == null) {
			return;
		}
		language= request.getParameter("lang");
		if (language == null) {
			language= "en";
		}
	}
	
	private Series fetchSeriesFromTVDB () {
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		return tvdb.getSeries(id, language);
	}
	
	private String getHtml(Series s) {
		StringBuilder html= new StringBuilder();
		html.append("<h1>Series Info:</h1>");
		
		html.append("id: " + s.getId() + "<br />");
		html.append("name: " + s.getName() + "<br />");
		for (String a : s.getActors()) {
			html.append("<t />Actor: " + a  + "<br />");
		}
		html.append("first aired: " + s.getFirstAired() + "<br />");
		html.append("banner: " + s.getBanner() + "<br />");
		html.append("imdb: " + s.getImdbId() + "<br />");
		html.append("overview: " + s.getOverview().getValue() + "<br />");
		
		return html.toString();
	}
}
