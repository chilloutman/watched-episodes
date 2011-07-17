package watchedepisodes.thetvdbapi.xmlparser;

@SuppressWarnings("serial")
public class ParseException extends Exception {
	@Override
	public String toString () {
		return super.toString() + ": Could not parse the response from the server";
	}
}
