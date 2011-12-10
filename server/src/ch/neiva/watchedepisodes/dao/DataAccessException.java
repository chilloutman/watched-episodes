package ch.neiva.watchedepisodes.dao;

@SuppressWarnings("serial")
public class DataAccessException extends Exception {
	@Override
	public String toString () {
		return super.toString() + ": Could not retrieve the requestet data.";
	}
}
