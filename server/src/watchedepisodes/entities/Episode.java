package watchedepisodes.entities;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;


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
	private String overview;
	@Persistent
	private String firstAired;
	@Persistent
	private String imdbId;
	@Persistent
	private String rating;
	
	@Persistent
	private List<String> writers = new ArrayList<String>();
	@Persistent
	private List<String> directors = new ArrayList<String>();
	@Persistent
	private List<String> guestStars = new ArrayList<String>();
	
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
	public String getOverview() {
		return overview;
	}
	public void setOverview(String overview) {
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
	public String getImdbId() {
		return imdbId;
	}
	public void setImdbId(String imdbId) {
		this.imdbId = imdbId;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public List<String> getWriters() {
		return writers;
	}
	public void setWriters(List<String> writers) {
		this.writers = writers;
	}
	public List<String> getDirectors() {
		return directors;
	}
	public void setDirectors(List<String> directors) {
		this.directors = directors;
	}
	public List<String> getGuestStars() {
		return guestStars;
	}
	public void setGuestStars(List<String> guestStars) {
		this.guestStars = guestStars;
	}
}
