package ch.neiva.xmlparser;

public class XMLElement {
	private String name;
	private String parentName;
	private String content;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getParentName() {
		return (parentName == null) ? "" : parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	void reset () {
		this.name= null;
		this.parentName= null;
		this.content= null;
	}
	
	@Override
	public String toString () {
		return "<" + name + ">" + content + "</" + name + ">";
	}
}
