package watchedepisodes.entities;

import java.util.Date;
import java.util.List;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Text;

@PersistenceCapable
public class Series {
	@PrimaryKey
	private String id;
	@Persistent (mappedBy= "series")
	private List<Episode> episodes;
	
	@Persistent
	private String name;
	@Persistent
	private Text overview;
	
	@Persistent
	private Date firstAired;
	@Persistent
	private String banner;
	@Persistent
	private String imdbId;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setEpisodes(List<Episode> episodes) {
		this.episodes = episodes;
	}
	public List<Episode> getEpisodes() {
		return episodes;
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
	public Date getFirstAired() {
		return firstAired;
	}
	public void setFirstAired(Date firstAired) {
		this.firstAired = firstAired;
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
