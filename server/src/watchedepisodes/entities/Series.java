package watchedepisodes.entities;

import java.util.List;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Text;

@PersistenceCapable
public class Series {
	@PrimaryKey
	private Key key;
	@Persistent
	private String id;
	@Persistent
	private String language;
	@Persistent
	private List<Season> seasons;
	
	@Persistent
	private String name;
	@Persistent
	private Text overview;
	
	@Persistent
	private String firstAired;
	@Persistent
	private List<String> actors;
	@Persistent
	private String banner;
	@Persistent
	private String imdbId;
	
	public void generateKey() throws Exception {
		if (id != null && language != null) {
			this.key= KeyFactory.createKey(Series.class.getSimpleName(), id + language);
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getLanguage() {
		return language;
	}
	public void setSeasons(List<Season> seasons) {
		this.seasons = seasons;
	}
	public List<Season> getSeasons() {
		return seasons;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Text getOverview() {
		return overview;
	}
	public void setOverview(Text overview) {
		this.overview = overview;
	}
	public String getFirstAired() {
		return firstAired;
	}
	public void setFirstAired(String firstAired) {
		this.firstAired = firstAired;
	}
	public void setActors(List<String> actors) {
		this.actors = actors;
	}
	public List<String> getActors() {
		return actors;
	}
	public String getBanner() {
		return banner;
	}
	public void setBanner(String banner) {
		this.banner = banner;
	}
	public String getImdbId() {
		return imdbId;
	}
	public void setImdbId(String imdbId) {
		this.imdbId = imdbId;
	}
}
