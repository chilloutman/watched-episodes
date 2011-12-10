package ch.neiva.watchedepisodes.thetvdbapi;

import java.util.ArrayList;
import java.util.List;

public class TVDBUpdates {
	
	private long unixTime;
	private ArrayList<String> seriesIds;
	
	public TVDBUpdates () {
		seriesIds = new ArrayList<String>();
	}
	
	public long getUnixTime () {
		return unixTime;
	}
	
	public void setUnixTime (long unixTime) {
		this.unixTime = unixTime;
	}
	
	public List<String> getUpdatedSeriesIds () {
		return seriesIds;
	}
	
	public void addSeriesId (String seriesId) {
		seriesIds.add(seriesId);
	}
}
