package watchedepisodes.test;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.moviejukebox.thetvdb.TheTVDB;
import com.moviejukebox.thetvdb.model.Episode;
import com.moviejukebox.thetvdb.model.Series;

@SuppressWarnings("serial")
public class TVServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/plain");
		
		TheTVDB tvDB = new TheTVDB("0629B785CE550C8D");
		
		// search for Series by name and language
		// the language is optional and may be null, which would end up defaulting to english
		// the Resulting Series objects from this call have limited information since it is a generic search
		// searchSeries(String title, String language)
		List<Series> results= tvDB.searchSeries("The Walking Dead", "en");
		
		resp.getWriter().println(results.size() + ":");
		for (Series s : results) {
			resp.getWriter().println("\t" + s.getSeriesName());
		}
		
		// obtain full Series details by id
		// may use the series.getId() method from the previous search
		// the language is optional and will default to english if null, but if present the resulting descriptions will be in that language
		// getSeries(String id, String language)
		Series series= tvDB.getSeries("73739", "en");
		resp.getWriter().println(series.getSeriesName());

		// obtain detailed Episode data
		// again, the language is optional and will default to english if null, but will return details in that language if present
		// getEpisode(String id, int seasonNbr, int episodeNbr, String language)
		Episode episode= tvDB.getEpisode("73739", 2, 3, "en");
	}
}
