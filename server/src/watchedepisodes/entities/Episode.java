package watchedepisodes.entities;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Text;


@PersistenceCapable
public class Episode {
	@PrimaryKey // Key is generated from "id + language"
	private Key key;
	@Persistent
	private String id;
	@Persistent
	private String language;
	@Persistent
	private Series series;
	
	@Persistent
	private String episodeName;
	@Persistent
	private int seasonNumber;
	@Persistent
	private int episodeNumber;
	
	@Persistent
	private Text overview;
	@Persistent
	private String firstAired;
	@Persistent
	private String rating;
	
	@Persistent
	private String writer;
	@Persistent
	private String director;
	@Persistent
	private List<String> guestStars = new ArrayList<String>();
	
	public void generateKey() throws Exception {
		if (id != null && language != null) {
			this.key= KeyFactory.createKey(Episode.class.getSimpleName(), id + language);
		} else {
			String message= "Could not generate key for series because id or language was missing!";
			System.err.println(message);
			throw new Exception(message);
		}
	}
	public void setKey(Key key) {
		this.key = key;
	}
	public Key getKey() {
		return key;
	}
	public Series getSeries() {
		return series;
	}
	public void setSeries(Series series) {
		this.series = series;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEpisodeName() {
		return episodeName;
	}
	public void setEpisodeName(String episodeName) {
		this.episodeName = episodeName;
	}
	public int getSeasonNumber() {
		return seasonNumber;
	}
	public void setSeasonNumber(int seasonNumber) {
		this.seasonNumber = seasonNumber;
	}
	public int getEpisodeNumber() {
		return episodeNumber;
	}
	public void setEpisodeNumber(int episodeNumber) {
		this.episodeNumber = episodeNumber;
	}
	public Text getOverview() {
		return overview;
	}
	public void setOverview(Text overview) {
		this.overview = overview;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getFirstAired() {
		return firstAired;
	}
	public void setFirstAired(String firstAired) {
		this.firstAired = firstAired;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public List<String> getGuestStars() {
		return guestStars;
	}
	public void setGuestStars(List<String> guestStars) {
		this.guestStars = guestStars;
	}
}
