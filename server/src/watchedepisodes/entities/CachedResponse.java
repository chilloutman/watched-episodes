package watchedepisodes.entities;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Blob;
import com.google.appengine.api.datastore.Key;
import com.google.protobuf.GeneratedMessage;

@PersistenceCapable
public class CachedResponse {
	@PrimaryKey
	private Key key;
	@Persistent
	private long unixTime;
	@Persistent
	private Blob messsageBlob;
	@Persistent
	private String messageType;
	
	public CachedResponse() {
		unixTime = System.currentTimeMillis() / 1000L;
	}
	
	public CachedResponse(Key key, GeneratedMessage message, String messageType) {
		this();
		setMessage(message);
		setKey(key);
	}
	
	public void setMessage (GeneratedMessage message) {
		messsageBlob = new Blob(message.toByteArray());
	}
	
	public byte[] getMessageBytes () {
		return messsageBlob.getBytes();
	}

	public Key getKey () {
		return key;
	}

	public void setKey (Key key) {
		this.key = key;
	}

	public long getUnixTime () {
		return unixTime;
	}

	public void setUnixTime (long unixTime) {
		this.unixTime = unixTime;
	}
}
