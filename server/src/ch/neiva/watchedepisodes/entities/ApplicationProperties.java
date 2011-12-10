package ch.neiva.watchedepisodes.entities;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

@PersistenceCapable
public class ApplicationProperties {
	
	@PrimaryKey
	private Key key;
	@Persistent
	private long previousRecacheTime;
	
	public ApplicationProperties () {
		key = KeyMaster.getApplicationPropertiesKey();
	}
	
	public long getPreviousRecacheTime () {
		return previousRecacheTime;
	}
	
	public void setPreviousRecacheTime (long previousRecacheTime) {
		this.previousRecacheTime = previousRecacheTime;
	}
}
