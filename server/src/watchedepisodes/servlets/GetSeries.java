package watchedepisodes.servlets;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.entities.Series;
import watchedepisodes.thetvdb.TVDB;
import watchedepisodes.tools.ServiceLocator;

@SuppressWarnings("serial")
public class GetSeries extends HttpServlet {
	
	public void doGet (HttpServletRequest req, HttpServletResponse resp) {
		String id= req.getParameter("id");
		if (id == null) {
			return;
		}
		String language= req.getParameter("lang");
		
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		Series series= tvdb.getSeries(id, language);
		
		resp.setContentType("text/html");
		
		try {
			resp.getWriter().append(getHtml(series));
		} catch (IOException e) {
			e.printStackTrace();
		}
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
