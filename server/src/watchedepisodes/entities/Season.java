package watchedepisodes.entities;

import java.util.List;

import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

public class Season {
	
	@PrimaryKey // Key is generated from "id + language"
	private Key key;
	@Persistent
	private int seasonNumber;
	@Persistent
	private List<Episode> episodes;
	
	public void generateKey (Key seriesKey) throws Exception {
		if (seriesKey != null) {
			this.key= KeyFactory.createKey(seriesKey, Season.class.getSimpleName(), seasonNumber);
		} else {
			String message= "Could not generate key for season because parent key was missing!";
			System.err.println(message);
			throw new Exception(message);
		}
	}

	public Key getKey() {
		return key;
	}

	public void setKey(Key key) {
		this.key = key;
	}

	public int getSeasonNumber() {
		return seasonNumber;
	}

	public void setSeasonNumber(int seasonNumber) {
		this.seasonNumber = seasonNumber;
	}

	public List<Episode> getEpisodes() {
		return episodes;
	}

	public void setEpisodes(List<Episode> episodes) {
		this.episodes = episodes;
	}
	
	
}
