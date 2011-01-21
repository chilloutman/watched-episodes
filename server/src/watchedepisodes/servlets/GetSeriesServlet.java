package watchedepisodes.servlets;

import java.io.IOException;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import watchedepisodes.entities.Series;
import watchedepisodes.servlets.protocols.GetSeriesProtocol.PBSeries;
import watchedepisodes.thetvdb.TVDB;
import watchedepisodes.thetvdb.TVDBException;
import watchedepisodes.tools.ServiceLocator;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("serial")
public class GetSeriesServlet extends AbstractServlet {
	
	private String id;
	private String language;
	
	public void doGet (HttpServletRequest request, HttpServletResponse response) {
		id= request.getParameter("id");
		language= getLanguage(request);
		
		PersistenceManager pm= ServiceLocator.getPersistenceManagerFactory().getPersistenceManager();
		Series series= null;
		Key key= KeyFactory.createKey(Series.class.getSimpleName(), id + language);
		
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
		writeResponse(response, request, series);
	}
	
	private Series fetchSeriesFromTVDB () throws TVDBException {
		TVDB tvdb= ServiceLocator.getTVDBInstance();
		return tvdb.getSeries(id, language);
	}
	
	private void writeResponse (HttpServletResponse response, HttpServletRequest request, Series series) {
		try {
			if (clientAcceptsProtocolBuffers(request)) {
				writeProtobuf(response, series);
			} else {
				writeHtml(response, series);
			}
		} catch (IOException e) {
			e.printStackTrace();
			response.setStatus(500);
		}
	}
	
	private void writeProtobuf(HttpServletResponse response, Series s) throws IOException {
		response.setContentType(protocolBuffers);
		
		PBSeries.Builder series= PBSeries.newBuilder();
		series.setId(s.getId());
		series.setLanguage(s.getLanguage());
		series.setName(s.getName());
		series.setOverview(s.getOverview().toString());
		series.setFirstAired(s.getFirstAired());
		series.addAllActors(s.getActors());
		series.setBanner(s.getBanner());
		series.setImdbId(s.getImdbId());
		
		PBSeries protobuf= series.build();
		response.setBufferSize(protobuf.getSerializedSize());
		protobuf.writeTo(response.getOutputStream());
	}
	
	private void writeHtml(HttpServletResponse response, Series s) throws IOException {
		if (s == null) {
			response.getWriter().append("Could not get series with this id:" + id);
		} else {
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
			
			response.getWriter().append(html.toString());
		}
		
	}
}
