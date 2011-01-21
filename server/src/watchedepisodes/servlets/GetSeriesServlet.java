package watchedepisodes.servlets;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.entities.Series;
import watchedepisodes.servlets.protocols.ProtocolFactory;
import watchedepisodes.thetvdb.TVDB;
import watchedepisodes.thetvdb.TVDBException;
import watchedepisodes.tools.ServiceLocator;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.protobuf.GeneratedMessage;

@SuppressWarnings("serial")
public class GetSeriesServlet extends AbstractServlet {
	
	private String id;
	private String language;
	
	public void doGet (HttpServletRequest request, HttpServletResponse response) {
		id= request.getParameter("id");
		language= getLanguage(request);
		
		PersistenceManager pm= ServiceLocator.getPersistenceManagerFactory().getPersistenceManager();
		Key key= KeyFactory.createKey(Series.class.getSimpleName(), id + language);
		
		Series series= null;
		
		try {
			series= pm.getObjectById(Series.class, key);
		} catch (JDOObjectNotFoundException e) {
			try {
				series= fetchSeriesFromTVDB();
				pm.makePersistent(series);
			} catch (TVDBException e1) {
				e1.printStackTrace();
				response.setStatus(500);
			}
		}
		
		pm.close();
		writeResponse(request, response, series);
	}
	
	private Series fetchSeriesFromTVDB () throws TVDBException {
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		return tvdb.getSeries(id, language);
	}
	
	private void writeResponse (HttpServletRequest request, HttpServletResponse response, Series series) {
		if (clientAcceptsProtocolBuffers(request)) {
			writeProtobufResponse(response, getProtocolMessage(series));
		} else {
			writeHtmlResponse(response, getHtml(series));
		}
	}
	
	private GeneratedMessage getProtocolMessage (Series series) {
		return ProtocolFactory.buildGetSeriesProto(series);
	}
	
	private String getHtml (Series series) {
		StringBuilder html= new StringBuilder();
		
		if (series == null) {
			html.append("Could not get series with this id:" + id);
		} else {
			html.append("<h1>Series Info:</h1>");
			
			html.append("id: " + series.getId() + "<br />");
			html.append("name: " + series.getName() + "<br />");
			for (String a : series.getActors()) {
				html.append("<t />Actor: " + a  + "<br />");
			}
			html.append("first aired: " + series.getFirstAired() + "<br />");
			html.append("banner: " + series.getBanner() + "<br />");
			html.append("imdb: " + series.getImdbId() + "<br />");
			html.append("overview: " + series.getOverview().getValue() + "<br />");
		}
		
		return html.toString();
	}
}
